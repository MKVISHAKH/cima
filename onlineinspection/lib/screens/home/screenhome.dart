import 'dart:developer';

import 'package:onlineinspection/core/hook/hook.dart';

class Screenhome extends StatefulWidget {
  const Screenhome({super.key});

  @override
  State<Screenhome> createState() => _ScreenhomeState();
}

class _ScreenhomeState extends State<Screenhome> {
  String locationMessage = 'Current Location of the User';
  Timer? locationTimer;
  double doublelat = 0;
  double doublelong = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Livelocationfun.instance.startTracking(
          context: context,
          onLocationUpdate: (position) {
            setState(() {
              doublelat = position.latitude;
              doublelong = position.longitude;
              locationMessage =
                  'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
              log("homescreen init:$locationMessage");
            });
          });
    });
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
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
                  Livelocationfun.instance.stopTracking();
                },
                child: Text('YES',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ));

  @override
  void dispose() {
    Livelocationfun.instance.stopTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionTimer =
        (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).sessionTimer;

    return ActivityMonitor(
      sessionTimer: sessionTimer,
      child: PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) async {
          // log('BackButton pressed!');
          if (!didPop) {
            //final nav=Navigator.of(context);
            if (didPop) return;
            final result = await showWarning(context);
            // print(result);
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
                        height: MediaQuery.of(context).size.height / 1.669,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              // bottomLeft: Radius.circular(50)
                            )),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0),
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
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04,
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
                        "CO-OPERATIVE INSPECTION MOBILE APP", // Replace with your dynamic name
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textScaler: TextScaler.noScaling,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.492,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,

                        // borderRadius:const BorderRadius.only(bottomRight: Radius.circular(70))
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.489,
                      //padding: const EdgeInsets.only(top: 10, bottom: 10),
                      decoration: const BoxDecoration(
                          color: Color(0xffAFDCEC),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(55),
                            // topRight: Radius.circular(30),
                            // bottomLeft: Radius.circular(30),
                            // bottomRight: Radius.circular(30),
                          )),
                      child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.4,
                            height: MediaQuery.of(context).size.height / 2.7,
                            child: GridView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 120,
                              ),
                              children: [
                                InkWell(
                                  splashColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryFixed,
                                  onTap: () async {
                                    //_startLocationCheckTimer();

                                    if (doublelat != 0 && doublelong != 0) {
                                      try {
                                        SocietyListFunctions.instance
                                            .getSocietyList(
                                                doublelat, doublelong, context);
                                        Navigator.pushReplacement(context,
                                            Approutes().assignedscreen);
                                      } catch (e) {
                                        // Handle parsing error, e.g., show a message to the user
                                        print(
                                            "Failed to parse coordinates: $e");
                                      }
                                    } else {
                                      // Show an error message if coordinates are unavailable
                                      Livelocationfun.instance.startTracking(
                                          context: context,
                                          onLocationUpdate: (position) {
                                            setState(() {
                                              doublelat = position.latitude;
                                              doublelong = position.longitude;
                                              locationMessage =
                                                  'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                              log("homescreen notready:$locationMessage");
                                            });
                                          });
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            "assets/home/inspection.jpg",
                                            fit: BoxFit.contain,
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        const Text(
                                          "Inspection",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Poppins-Medium'),
                                          textScaler: TextScaler.noScaling,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryFixed,
                                  onTap: () {
                                    SchedulelistFun.instance
                                        .getScheduleList(context);
                                    Navigator.pushReplacement(
                                        context, Approutes().scheduleScreen);
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    margin: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            "assets/home/schedule.jpg",
                                            fit: BoxFit.contain,
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        const Text(
                                          'My Schedule',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Poppins-Medium'),
                                          textScaler: TextScaler.noScaling,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryFixed,
                                  onTap: () {
                                    SchedulelistFun.instance
                                        .getSchdlcmpltLst(context);
                                    Navigator.pushReplacement(
                                        context, Approutes().cmpltRprtScreen);
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    margin: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            "assets/home/reports001.jpg",
                                            fit: BoxFit.contain,
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        const Text(
                                          'Reports',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Poppins-Medium'),
                                          textScaler: TextScaler.noScaling,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  splashColor: Theme.of(context)
                                      .colorScheme
                                      .secondaryFixed,
                                  onTap: () {
                                    SchedulelistFun.instance
                                        .getActionRprt(context);
                                    Navigator.pushReplacement(
                                        context, Approutes().screensActionRprt);
                                  },
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    margin: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            "assets/home/action001.jpg",
                                            fit: BoxFit.contain,
                                            width: 60,
                                            height: 60,
                                          ),
                                        ),
                                        const Text(
                                          'Actions',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'Poppins-Medium'),
                                          textScaler: TextScaler.noScaling,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                        // Stack(
                        //   children: [
                        //     IconButton(
                        //       icon: Icon(
                        //         Icons.notifications,
                        //         color: Theme.of(context).colorScheme.onPrimary,
                        //         size: 25,
                        //       ),
                        //       onPressed: () {
                        //         // Handle notification button press
                        //       },
                        //     ),
                        //     Positioned(
                        //       right: 10,
                        //       top: 8,
                        //       child: Container(
                        //         padding:const EdgeInsets.all(2),
                        //         decoration:const BoxDecoration(
                        //           color: Colors.red,
                        //           shape: BoxShape.circle,
                        //         ),
                        //         constraints:const BoxConstraints(
                        //           minWidth: 10,
                        //           minHeight: 10,
                        //         ),
                        //         child:const Text(
                        //           '', // Replace with dynamic count or leave blank for just a dot
                        //           style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: 10,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //           textAlign: TextAlign.center,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
