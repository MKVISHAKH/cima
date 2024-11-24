import 'package:onlineinspection/core/hook/hook.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenQuery extends StatefulWidget {
  const ScreenQuery(
      {super.key,
      required this.bankname,
      required this.branch,
      required this.regNo,
      required this.lastinspdt,
      required this.name,
      required this.role,
      required this.activity});
  final String? bankname;
  final String? branch;
  final String? regNo;
  final String? lastinspdt;
  final String? name;
  final String? role;
  final String? activity;

  @override
  State<ScreenQuery> createState() => _ScreenQueryState();
}

class _ScreenQueryState extends State<ScreenQuery> {
  String locationMessage = 'Current Location of the User';
  String lat = '';
  String long = '';
  Timer? locationTimer;
  List<Datum>? questval;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestLocationPermission();
    });
  }

  @override
  void dispose() {
    selectedFormatNotifier.value = '';
    super.dispose();
  }

  Future<void> getquestions() async {
    //regNo=sharedValue.
  }
  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      _showMandatoryPermissionDialog();
    } else if (permission == LocationPermission.deniedForever) {
      _showPermissionPermanentlyDeniedDialog();
    } else {
      await _getCurrentLocation();
      //  _startLocationCheckTimer();
    }
  }

  void _startLocationCheckTimer() {
    locationTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await _showLocationSettingsDialog();
        return;
      } else {
        // Optionally update location if enabled
        await _getCurrentLocation();
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _showLocationSettingsDialog();
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    if (mounted) {
      lat = '${position.latitude}';
      long = '${position.longitude}';
      setState(() {
        locationMessage = 'Latitude: $lat, Longitude: $long';
      });

      if (lat.isNotEmpty && long.isNotEmpty) {
        try {
          double doublelat = double.parse(lat);
          double doublelong = double.parse(long);

          final sharedValue = await SharedPrefManager.instance.getSocietyinfo();
          final usrval = await SharedPrefManager.instance.getSharedData();
          final queReq = Getbasicinfo.val(
              schedulerId: sharedValue.schedulerId,
              schedulerDate: sharedValue.schedulerDate,
              userId: usrval!.userId,
              socId: sharedValue.socId,
              branchId: sharedValue.branchId,
              lattitude: doublelat,
              longitude: doublelong,
              activity: widget.activity);
          questval = await QuestionsFunctions.instance.fetchQueStrt(queReq);
          if (questval == null) {
            Fluttertoast.showToast(
                msg: "No Data Found",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 15.0);
          } else {
            selectedFormatNotifier.value = '';
            if (mounted) {
              setState(() {});
            }
          }
        } catch (e) {
          print("Failed to parse coordinates: $e");
        }
      } else {
        Fluttertoast.showToast(
            msg: "Location are not ready yet.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 15.0);
        print("Location coordinates are not ready yet.");
      }

      liveLocation();
    }
  }

  Future<void> _showLocationSettingsDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Enable Location Services"),
        content: const Text(
            "Location services are required to proceed. Please enable them in your device settings."),
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

  void _showMandatoryPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission Required"),
        content: const Text(
            "Location access is required to proceed. Please enable it in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await Permission.location.request();
            },
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }

  void _showPermissionPermanentlyDeniedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Location Permission Required"),
        content: const Text(
            "Please go to settings and enable location permission manually."),
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

  void liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      if (mounted) {
        lat = position.latitude.toString();
        long = position.longitude.toString();
        setState(() {
          locationMessage = 'Latitude: $lat,Longitude: $long';
        });
      }
    });
  }

  // Future<bool?> popscreen(BuildContext context) async {
  //   selectedFormatNotifier.value=
  //   // Navigator.push(context, Approutes().homescreen);
  //   return true;
  // }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            if (!didPop) {
              if (didPop) return;
              await warningBox(context);
            }
            //log('BackButton pressed!');
          },
          child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Theme.of(context).colorScheme.primaryFixed,
              appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      warningBox(context);
                    },
                  ),
                  title: Text(
                    "Questionnaire",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  )),
              body: ListView(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary
                        ],
                      ),
                      // borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        widget.bankname ?? 'User',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Branch: ${widget.branch ?? 'Branch'}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            'Reg.No: ${widget.regNo ?? 'RegNo'}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            'Last Inspection Date: ${widget.lastinspdt ?? ''}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (questval != null && questval!.isNotEmpty) ...[
                          Text(
                            'Q.${questval!.first.sortOrder}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            questval!.first.question ?? '',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: questval!.first.option?.length ?? 0,
                              itemBuilder: (context, index) {
                                final option =
                                    questval!.first.option?[index].option ??
                                        'activity';
                                return FormatRadioButton(
                                  title: option,
                                  type: option,
                                  txtstyl:
                                      Theme.of(context).textTheme.displaySmall,
                                  color: const Color.fromARGB(255, 2, 73, 4),
                                );
                              },
                            ),
                          ),
                          Container(
                            height: 45,
                            width: 150,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.primary
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Theme(
                              data: MyTheme.buttonStyleTheme,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (lat.isNotEmpty && long.isNotEmpty) {
                                    try {
                                      String selectedValue =
                                          selectedFormatNotifier.value;
                                      if (selectedValue.isNotEmpty) {
                                        print(
                                            "Selected option: $selectedValue");
                                        double doublelat = double.parse(lat);
                                        double doublelong = double.parse(long);

                                        final sharedValue =
                                            await SharedPrefManager.instance
                                                .getSocietyinfo();
                                        final usrval = await SharedPrefManager
                                            .instance
                                            .getSharedData();
                                        final queReq = QuestionReq(
                                          questionId:
                                              questval?.single.questionId,
                                          inspectionId: questval?.single.inspId,
                                          userId: usrval!.userId,
                                          socId: sharedValue.socId,
                                          branchId: sharedValue.branchId,
                                          answer: selectedValue,
                                          lattitude: doublelat,
                                          longitude: doublelong,
                                        );
                                        questval = await QuestionsFunctions
                                            .instance
                                            .fetchQueUpdt(queReq);
                                        if (questval == null ||
                                            questval == []) {
                                          Fluttertoast.showToast(
                                              msg: "No Data Found",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.white,
                                              textColor: const Color.fromRGBO(
                                                  0, 0, 0, 1),
                                              fontSize: 15.0);
                                        } else if (questval!.single.questatus ==
                                            true) {
                                          selectedFormatNotifier.value = '';
                                          queSubmit(
                                              _scaffoldKey.currentContext!);
                                        } else {
                                          selectedFormatNotifier.value = '';
                                          if (mounted) {
                                            setState(() {});
                                          }
                                        }
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "Please select one option",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.white,
                                            textColor: Colors.black,
                                            fontSize: 15.0);
                                      }
                                    } catch (e) {
                                      print("Failed to parse coordinates: $e");
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Location are not ready yet.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.white,
                                        textColor: Colors.black,
                                        fontSize: 15.0);

                                    print(
                                        "Location coordinates are not ready yet.");
                                  }
                                },
                                child: Text(
                                  'NEXT',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ),
                            ),
                          ),
                        ] else ...[
                          const Center(child: CircularProgressIndicator()),
                        ],
                      ],
                    ),
                  ),
                  // buildQuestion(),
                ],
              )),
        )
      ],
    );
  }

  Future warningBox(BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: Center(
                child: Text("Are you sure Do You want to exit Questionnaire?",
                    style: Theme.of(context).textTheme.titleSmall)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('NO',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  selectedFormatNotifier.value = '';
                  selectedItems.value = {0};
                  Navigator.pushReplacement(
                      context, Approutes().assignedscreen);
                },
                child: Text('YES',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ));

  queSubmit(BuildContext context) async => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            title: Center(
                child: Text("Inspection completed Successfully",
                    style: Theme.of(context).textTheme.titleSmall)),
            actions: [
              Container(
                height: 45,
                width: 130,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.primary
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Theme(
                  data: MyTheme.buttonStyleTheme,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (lat.isNotEmpty && long.isNotEmpty) {
                        try {
                          double doublelat = double.parse(lat);
                          double doublelong = double.parse(long);

                          SocietyListFunctions.instance
                              .getSocietyList(doublelat, doublelong);

                          selectedFormatNotifier.value = '';
                          selectedItems.value = {0};
                          Navigator.pushReplacement(
                              context, Approutes().assignedscreen);
                        } catch (e) {
                          // Handle parsing error, e.g., show a message to the user
                          print("Failed to parse coordinates: $e");
                        }
                      } else {
                        // Show an error message if coordinates are unavailable
                        Fluttertoast.showToast(
                            msg: "Location are not ready yet.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            fontSize: 15.0);
                        print("Location coordinates are not ready yet.");
                      }
                    },
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ],
          )));
}
