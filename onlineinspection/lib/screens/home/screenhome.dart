import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/functions/schedule/scheduleListFun.dart';
import 'package:permission_handler/permission_handler.dart';

class Screenhome extends StatefulWidget {
  const Screenhome({super.key});

  @override
  State<Screenhome> createState() => _ScreenhomeState();
}

class _ScreenhomeState extends State<Screenhome> {
  String locationMessage = 'Current Location of the User';
  String lat = '';
  String long = '';
  Timer? locationTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestLocationPermission();
      //_startLocationCheckTimer();
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

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            title: Center(
                child: Text("Do You want to exit App?",
                    style: Theme.of(context).textTheme.titleSmall)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => Navigator.pop(context, false),
                child: Text('NO',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text('YES',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ));
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        // log('BackButton pressed!');
        if (!didPop) {
          //final nav=Navigator.of(context);
          if (didPop) return;
          final result = await showWarning(context);
          print(result);
          if (result != null && result) {
            SystemNavigator.pop(); // This will properly exit the app
          }
        }
      },
      child: Scaffold(
        drawer: const Navbar(),
        body: Material(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Color(0xffAFDCEC),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.6,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,

                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            //bottomLeft: Radius.circular(50)
                            )
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top:60.0),
                          child: Lottie.asset(
                            'assets/animation/home/Animation - 1730091121508.json',
                            width: MediaQuery.of(context).size.width,
                            //height: MediaQuery.of(context).size.height/2
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.14,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: Container(
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      "CO-OPERATIVE INSPECTION APP", // Replace with your dynamic name
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.66,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,

                      //borderRadius:const BorderRadius.only(bottomRight: Radius.circular(70))
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.66,
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    decoration: const BoxDecoration(
                      color: Color(0xffAFDCEC),
                      borderRadius:  BorderRadius.only(
                          topLeft: Radius.circular(50),
                          // topRight: Radius.circular(30),
                          // bottomLeft: Radius.circular(30),
                          // bottomRight: Radius.circular(30),
                          )
                    ),
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 120,
                          ),
                          children: [
                            InkWell(
                              splashColor:
                                  Theme.of(context).colorScheme.secondaryFixed,
                              onTap: () async {
                                _startLocationCheckTimer();

                                if (lat.isNotEmpty && long.isNotEmpty) {
                                  try {
                                    double doublelat = double.parse(lat);
                                    double doublelong = double.parse(long);

                                    SocietyListFunctions.instance
                                        .getSocietyList(doublelat, doublelong);
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
                                  print(
                                      "Location coordinates are not ready yet.");
                                }
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                margin: const EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        "assets/home/22989318.jpg",
                                        fit: BoxFit.contain,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    const Text(
                                      "Audit",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Medium'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor:
                                  Theme.of(context).colorScheme.secondaryFixed,
                              onTap: () {
                                SchedulelistFun.instance.getScheduleList();
                                Navigator.pushReplacement(context, Approutes().scheduleScreen);
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                margin: const EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        "assets/home/istockphoto-1163732070-612x612.jpg",
                                        fit: BoxFit.contain,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    const Text('Schedule',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Poppins-Medium')),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor:
                                  Theme.of(context).colorScheme.secondaryFixed,
                              onTap: () {
                                SchedulelistFun.instance.getSchdlcmpltLst();
                                Navigator.pushReplacement(context, Approutes().cmpltRprtScreen);
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 5,
                                margin: const EdgeInsets.all(5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        "assets/home/report.jpg",
                                        fit: BoxFit.contain,
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                    const Text('Reports',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontFamily: 'Poppins-Medium')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height / 18,
                        // ),
                        // Container(
                        //   height: 45,
                        //   width: 200,
                        //   decoration: BoxDecoration(
                        //     gradient: LinearGradient(
                        //       begin: Alignment.topLeft,
                        //       end: Alignment.bottomRight,
                        //       colors: [
                        //         Theme.of(context).colorScheme.primary,
                        //         Theme.of(context).colorScheme.primary
                        //       ],
                        //     ),
                        //     borderRadius: BorderRadius.circular(12.0),
                        //   ),
                        //   child: Theme(
                        //     data: MyTheme.buttonStyleTheme,
                        //     child: ElevatedButton(
                        //       onPressed: () async {
                        //         _startLocationCheckTimer();
                        //         // double doublelat = double.parse(lat);
                        //         // double doublelong = double.parse(long);

                        //         // SocietyListFunctions.instance.getSocietyList(doublelat, doublelong);
                        //         // Navigator.pushReplacement(
                        //         //     context, Approutes().assignedscreen);
                        //         if (lat.isNotEmpty && long.isNotEmpty) {
                        //           try {
                        //             double doublelat = double.parse(lat);
                        //             double doublelong = double.parse(long);

                        //             SocietyListFunctions.instance
                        //                 .getSocietyList(doublelat, doublelong);
                        //             Navigator.pushReplacement(
                        //                 context, Approutes().assignedscreen);
                        //           } catch (e) {
                        //             // Handle parsing error, e.g., show a message to the user
                        //             print("Failed to parse coordinates: $e");
                        //           }
                        //         } else {
                        //           // Show an error message if coordinates are unavailable
                        //           Fluttertoast.showToast(
                        //               msg: "Location are not ready yet.",
                        //               toastLength: Toast.LENGTH_SHORT,
                        //               gravity: ToastGravity.CENTER,
                        //               timeInSecForIosWeb: 1,
                        //               backgroundColor: Colors.white,
                        //               textColor: Colors.black,
                        //               fontSize: 15.0);
                        //           print(
                        //               "Location coordinates are not ready yet.");
                        //         }
                        //       },
                        //       child: Text(
                        //         'Get Started',
                        //         style: Theme.of(context).textTheme.titleMedium,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        //  const SizedBox(
                        //   height: 10,
                        // ),
                        // Text('Coperative Inspection App',
                        // style: Theme.of(context).textTheme.titleMedium,),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  right: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 30,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Theme.of(context).colorScheme.onPrimary,
                          size: 25,
                        ),
                        onPressed: () {
                          // Handle notification button press
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
