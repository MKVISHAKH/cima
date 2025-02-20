import 'dart:developer';
//import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/core/hook/hook.dart';
import 'package:permission_handler/permission_handler.dart';

class Livelocationfun {
  Livelocationfun._internal();
  static Livelocationfun instance = Livelocationfun._internal();
  Livelocationfun factory() {
    return instance;
  }

  ValueNotifier<List<DatumValue>> getLocationUpdtListNotifier =
      ValueNotifier([]);

  StreamSubscription<Position>? _positionSubscription;
  Timer? _locationCheckTimer;
  bool _isServiceRestarting = false; // Flag to prevent multiple restarts

  void startTracking({
    required BuildContext context,
    required Function(Position) onLocationUpdate,
  }) async {
    await requestLocationPermission(context);
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) await _showLocationSettingsDialog(context);
      return;
    }
    if (!context.mounted) return;

    await _getInitialLocation(context, onLocationUpdate);
    if (!context.mounted) return;

    _startLiveLocationStream(context, onLocationUpdate);
    if (!context.mounted) return;

    _startLocationCheckTimer(context);
  }

  Future<void> _getInitialLocation(
      BuildContext context, Function(Position) onLocationUpdate) async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      onLocationUpdate(position);
    } catch (e) {
      _showErrorToast("Loading...");
    }
  }

  void _startLiveLocationStream(
      BuildContext context, Function(Position) onLocationUpdate) {
    try {
      _positionSubscription?.cancel(); // Cancel any previous subscription
      LocationSettings locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
      _positionSubscription =
          Geolocator.getPositionStream(locationSettings: locationSettings)
              .listen(
        (Position position) {
          onLocationUpdate(position);
        },
        onError: (error) async {
          log("Stream error: $error");
          if (error is LocationServiceDisabledException) {
            _positionSubscription?.cancel();
            if (!_isServiceRestarting) {
              _isServiceRestarting = true;
              await _handleLocationDisabled(context);
              _isServiceRestarting = false;
            }
          } else {
            _showErrorToast("Location error occurred.");
          }
        },
      );
    } catch (e) {
      _showErrorToast("Failed to start location tracking.");
    }
  }

  Future<void> _handleLocationDisabled(BuildContext context) async {
    stopTracking();
    if (context.mounted) await _showLocationSettingsDialog(context);
  }

  void _startLocationCheckTimer(BuildContext context) {
    _locationCheckTimer =
        Timer.periodic(const Duration(seconds: 10), (timer) async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        log("Location service disabled. Stopping stream...");
        timer.cancel();
        if (context.mounted) await _showLocationSettingsDialog(context);
      } else if (_positionSubscription == null ||_positionSubscription!.isPaused) {
        log("Restarting location service...");
           // _showErrorToast("Restarting location service...");

        if (!context.mounted) return;
        _startLiveLocationStream(context, (position) => {});
      }
    });
  }

  void stopTracking() {
    _positionSubscription?.cancel();
    _locationCheckTimer?.cancel();
    _positionSubscription = null;
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) _showPermissionPermanentlyDeniedDialog(context);
    }
  }

  Future<void> _showLocationSettingsDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        title: const Text("Enable Location Services"),
        content: const Text("Location services need to be enabled."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Geolocator.openLocationSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  void _showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        title: const Text("Permission Denied Forever"),
        content: const Text(
            "Location permission is permanently denied. Please enable it in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  void _showErrorToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 14.0,
    );
  }

  Future locationUpdtLst(BuildContext context) async {
    try {
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      String? message;

      final schedulReq = Societyreq(
        userId: sharedValue!.userId,
      );
      final scheduleLstresp = await Ciadata().locationupdtList(schedulReq);

      if (scheduleLstresp == null) {
        getLocationUpdtListNotifier.value.clear();
        getLocationUpdtListNotifier.value.addAll([]);
        getLocationUpdtListNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (scheduleLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(scheduleLstresp.toString());
        final sctyListRespVal =
            LocationUpdateList.fromJson(resultAsJson as Map<String, dynamic>);

        if (sctyListRespVal.status == 'success') {
          //print('sucess');
          final itemDet = sctyListRespVal.data ?? [];
          //print(item_det.);
          getLocationUpdtListNotifier.value.clear();
          getLocationUpdtListNotifier.value.addAll(itemDet);
          getLocationUpdtListNotifier.notifyListeners();
        } else if (sctyListRespVal.status == 'failure') {
          final itemDet = sctyListRespVal.data ?? [];
          getLocationUpdtListNotifier.value.clear();
          getLocationUpdtListNotifier.value.addAll(itemDet);
          getLocationUpdtListNotifier.notifyListeners();
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          scheduleLstresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (scheduleLstresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (scheduleLstresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getLocationUpdtListNotifier.value.clear();
        getLocationUpdtListNotifier.value.addAll([]);
        getLocationUpdtListNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future updateLocation(QuestionReq val, BuildContext context, String? screen) async {
    try {
      final loadingProvider = context.read<LoadingProvider>();
      String? message;

      loadingProvider.toggleLoading();

      final loginResponse = await Ciadata().locationUpdt(val);

      final resultAsjson = jsonDecode(loginResponse.toString());
      final loginval =
          Commonresp.fromJson(resultAsjson as Map<String, dynamic>);

      loadingProvider.reset();
      if (loginResponse == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loginResponse.statusCode == 200 &&
          loginval.status == 'success') {
        //final msg = loginval.message;
        if (!context.mounted) return;

        screen == scAddLoc
            ? locationUpdtLst(context)
            : SchedulelistFun.instance.getScheduleList(context);

        // Fluttertoast.showToast(
        //     msg: msg ?? '',
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 15.0);
        CommonFun.instance.showApierror(context, "Geolocation Updated Successfully");
        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.status == 'failure') {
       // final msg = loginval.message;

        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Could not Update Geolocation");
      } else if (message == 'Unauthenticated' ||
          loginResponse.statusCode == 401) {
        if (!context.mounted) return;

        CommonFun.instance.signout(context);
      } else if (loginResponse.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loginResponse.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
}
