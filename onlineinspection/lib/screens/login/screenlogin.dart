import 'dart:developer';
import 'package:onlineinspection/core/hook/hook.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _usercontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  bool passtoggle = true;
  String locationMessage = 'Current Location of the User';
  String lat = '';
  String long = '';
  double doublelat = 0;
  double doublelong = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //requestLocationPermission();
      Livelocationfun.instance.startTracking(
        context: context,
        onLocationUpdate: (position) {
          setState(() {
            doublelat = position.latitude;
            doublelong = position.longitude;
            locationMessage =
                'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
            log('asgnd screen  init:$locationMessage');
          });
        },
      );
    });
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
    }
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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      const BackgroundImage(),
      Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(50),
            elevation: 3,
            shadowColor: Theme.of(context).colorScheme.primary,
            child: SizedBox(
              width: 300,
              height: 450,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Theme(
                        data: MyTheme.googleFormTheme,
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'LOGIN',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 5),
                                child: TextFormField(
                                    controller: _usercontroller,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Enter valid Username";
                                      } else if (value.contains('.') ||
                                          value.contains("-") ||
                                          value.contains(" ") ||
                                          value.contains(",")) {
                                        return "Enter valid Username";
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context, Approutes().forgotusrScreen);
                              },
                              child: Text(
                                'Forgot Username?',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 5),
                                child: TextFormField(
                                    controller: _passcontroller,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      prefixIcon: Theme(
                                        data: MyTheme.appIconTheme,
                                        child: const Icon(
                                          Icons.lock,
                                        ),
                                      ),
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            passtoggle = !passtoggle;
                                          });
                                        },
                                        child: Theme(
                                          data: MyTheme.appIconTheme,
                                          child: Icon(
                                            passtoggle
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                        ),
                                      ),
                                    ),
                                    obscureText: passtoggle,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter password';
                                      }
                                      // else if (value.length < 8) {
                                      //   return 'Please enter atleast 8 characters';
                                      // }

                                      else if (value.contains(' ')) {
                                        return 'Remove space from password';
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context, Approutes().forgotpswrdScreen);
                              },
                              child: Text(
                                'Forgot Password?',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 45,
                              width: 200,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).colorScheme.secondary,
                                    Theme.of(context).colorScheme.secondary
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Theme(
                                data: MyTheme.buttonStyleTheme,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formkey.currentState!.validate()) {
                                      getlogin();
                                    }
                                  },
                                  child: Text(
                                    'LOGIN',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Consumer<LoadingProvider>(
                                builder: (context, loadingProvider, child) {
                              return loadingProvider.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color.fromARGB(255, 2, 128, 6),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Future getlogin() async {
    final loadingProvider = context.read<LoadingProvider>();

    loadingProvider.toggleLoading();
    final username = _usercontroller.text;
    final password = _passcontroller.text;

    final logreq = Loginreq(pen: username, password: password);

    final loginResponse = await Ciadata().login(logreq);
    final resultAsjson = jsonDecode(loginResponse.toString());
    final loginval = Loginresp.fromJson(resultAsjson as Map<String, dynamic>);

    loadingProvider.toggleLoading();
    if (loginResponse == null) {
      showLoginerror(_scaffoldKey.currentContext!, 1);
    } else if (loginResponse.statusCode == 200 &&
        loginval.status == 'success') {
      final sharedPrefLogin = Sharedpref.value(
          userId: loginval.data!.userId,
          pen: loginval.data!.pen,
          name: loginval.data!.name,
          mobile: loginval.data!.mobile,
          districtid: loginval.data!.districtId,
          talukid: loginval.data!.talukId,
          circleid: loginval.data!.circleId,
          roleid: loginval.data!.roleId,
          active: loginval.data!.active,
          accesstoken: loginval.data!.accessToken);
      addLoginShareddata(sharedPrefLogin);
      /*wklycollection function */

      /**************************/

      Navigator.pushReplacement(
          _scaffoldKey.currentContext!, Approutes().homescreen);

      //showLoginerror(_scaffoldKey.currentContext!);
    } else if (loginval.status == 'failure') {
      showLoginerror(_scaffoldKey.currentContext!, 2);
    } else {
      showLoginerror(_scaffoldKey.currentContext!, 3);
    }
  }

  Future showLoginerror(BuildContext? context, stat) async {
    //print('hi');
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Username or password incorrect",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  addLoginShareddata(Sharedpref value) async {
    await SharedPrefManager.instance.addSharedData(value);
  }
}
