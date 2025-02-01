import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenAssigned extends StatefulWidget {
  const ScreenAssigned({super.key});

  @override
  State<ScreenAssigned> createState() => _ScreenAssignedState();
}

class _ScreenAssignedState extends State<ScreenAssigned> {
  bool isButtonEnabled = true;
  String locationMessage = 'Current Location of the User';
  Timer? locationTimer;
  int? usrId;
  String? usrName;
  String? time;
  String? date;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isExpanded = false;
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
            log('asgnd screen  init:$locationMessage');
          });
        },
      );
      getShareddata();
    });
  }

  Future<void> getShareddata() async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    usrName = sharedValue?.name?.toUpperCase() ?? 'User';
    usrId = sharedValue!.userId;
  }

  Future<bool?> popscreen(BuildContext context) async {
    SocietyListFunctions.instance.getScietyListNotifier.value = [];
    Navigator.push(context, Approutes().homescreen);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final sessionTimer =
        (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).sessionTimer;

    return ActivityMonitor(
      sessionTimer: sessionTimer,
      child: Stack(
        children: [
          PopScope(
            canPop: false,
            onPopInvoked: (bool didPop) async {
              if (!didPop) {
                if (didPop) return;
                await popscreen(context);
              }
            },
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Theme.of(context).colorScheme.primaryFixed,
              appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: Theme.of(context).colorScheme.onPrimary),
                    onPressed: () {
                      SocietyListFunctions
                          .instance.getScietyListNotifier.value = [];
                      Navigator.pushReplacement(
                          context, Approutes().homescreen);
                    },
                  ),
                  title: Text(
                    "Scheduled Societies",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
              body: ListView(
                children: [
                  Container(
                    // margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: const BoxDecoration(
                      color: Color(0xff1569C7),
                    ),
                    child: Text(
                      'Welcome ${usrName ?? ''}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ValueListenableBuilder(
                        valueListenable:
                            SocietyListFunctions.instance.getScietyListNotifier,
                        builder: (BuildContext context, List<Society> newList,
                            Widget? _) {
                          return Column(
                            children: [
                              if (newList.isNotEmpty) ...[
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: newList.length,
                                  itemBuilder: (context, index) {
                                    final society = newList[index];
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                      ),
                                      child: Card(
                                        elevation: 3,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: isExpanded
                                                ? const Color(0xff1569C7)
                                                : society.active == true
                                                    ? const Color.fromARGB(
                                                        255,
                                                        2,
                                                        72,
                                                        4) // Active state color
                                                    : const Color(
                                                        0xff1569C7), // Inactive state color
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: ExpansionTile(
                                              title: Text(
                                                society.societyName ?? ' ',
                                                style: society.active == true
                                                    ? const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        fontFamily:
                                                            'Poppins-Medium')
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .displayMedium,
                                              ),
                                              onExpansionChanged:
                                                  (bool expanded) {
                                                setState(() {
                                                  isExpanded = expanded;
                                                });
                                              },
                                              children: [
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2.5,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: society
                                                          .branches!
                                                          .map((subItem) {
                                                        String? schDt =
                                                            subItem.schDate;
                                                        DateTime parseDate =
                                                            DateFormat(
                                                                    "yyyy-MM-dd")
                                                                .parse(schDt ??
                                                                    '');
                                                        var inputDate = DateTime
                                                            .parse(parseDate
                                                                .toString());
                                                        var outputFormat =
                                                            DateFormat(
                                                                'dd-MM-yyyy');
                                                        var schdldt =
                                                            outputFormat.format(
                                                                inputDate);
                                                        print(schdldt);
                                                        final now =
                                                            DateTime.now();
                                                        DateFormat dateFormat =
                                                            DateFormat(
                                                                "dd-MM-yyyy");
                                                        date = dateFormat
                                                            .format(now);
                                                        print(date);
                                                        double? dist =
                                                            subItem.distance;

                                                        String distance = '';
                                                        if (dist == null) {
                                                          dist = 0;
                                                          distance = '0';
                                                          isButtonEnabled =
                                                              false;
                                                        } else if (dist >=
                                                            1000) {
                                                          double dist1 =
                                                              dist / 1000;
                                                          String myString = dist1
                                                              .toStringAsFixed(
                                                                  1);
                                                          distance =
                                                              "${myString}km";
                                                          log('dist>1000 $dist:$maxdistScty');
                                                          if (dist <
                                                                  maxdistScty &&
                                                              schdldt == date) {
                                                            isButtonEnabled =
                                                                true;
                                                          } else {
                                                            isButtonEnabled =
                                                                false;
                                                          }
                                                        } else {
                                                          if (dist <
                                                                  maxdistScty &&
                                                              schdldt == date) {
                                                            log('dist<$dist:$maxdistScty');
                                                            isButtonEnabled =
                                                                true;
                                                            String myString = dist
                                                                .toStringAsFixed(
                                                                    1);
                                                            distance =
                                                                "${myString}m";
                                                          } else {
                                                            isButtonEnabled =
                                                                false;
                                                            String myString = dist
                                                                .toStringAsFixed(
                                                                    1);
                                                            distance =
                                                                "${myString}m";
                                                          }
                                                        }
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8.0,
                                                                  horizontal:
                                                                      5.0),
                                                          child: Card(
                                                            elevation: 3,
                                                            margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 5,
                                                                    horizontal:
                                                                        0),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: society
                                                                            .active ==
                                                                        true
                                                                    ? Colors
                                                                        .white // Active state color
                                                                    : Colors
                                                                        .white, // Inactive state color
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12),
                                                              ),
                                                              child: ListTile(
                                                                // Main title and subtitle
                                                                title: Column(
                                                                  children: [
                                                                    Text(
                                                                      subItem.branchName ??
                                                                          '',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headlineLarge,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            8),
                                                                    Text(
                                                                      'Schedule Date: $schdldt',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headlineSmall,
                                                                    ),
                                                                    Text(
                                                                      'Distance: $distance',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .headlineSmall,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            8),
                                                                    Container(
                                                                      height:
                                                                          30,
                                                                      width:
                                                                          110,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        gradient: isButtonEnabled
                                                                            ? const LinearGradient(
                                                                                begin: Alignment.topLeft,
                                                                                end: Alignment.bottomRight,
                                                                                colors: [
                                                                                  Color.fromARGB(255, 2, 72, 4),
                                                                                  Color.fromARGB(255, 2, 72, 4)
                                                                                ],
                                                                              )
                                                                            : const LinearGradient(
                                                                                begin: Alignment.topLeft,
                                                                                end: Alignment.bottomRight,
                                                                                colors: [
                                                                                  Colors.grey,
                                                                                  Color.fromARGB(255, 172, 168, 168)
                                                                                ],
                                                                              ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(12.0),
                                                                      ),
                                                                      child:
                                                                          Theme(
                                                                        data: MyTheme
                                                                            .buttonStyleTheme,
                                                                        child:
                                                                            ElevatedButton(
                                                                          onPressed: isButtonEnabled
                                                                              ? () async {
                                                                                  if (doublelat != 0 && doublelong != 0) {
                                                                                    try {
                                                                                      final socdet = Getbasicinfo.val(schedulerId: subItem.schedulerId, schedulerDate: subItem.schDate, userId: usrId, socId: society.socId, socName: society.societyName, branchId: subItem.branchId, lattitude: doublelat, longitude: doublelong, bName: subItem.branchName);

                                                                                      await SharedPrefManager.instance.setSocietyinfo(socdet);
                                                                                      if (!context.mounted) return;

                                                                                      buildQuery(socdet, context);
                                                                                    } catch (e) {
                                                                                      // Handle parsing error, e.g., show a message to the user
                                                                                      print("Failed to parse coordinates: $e");
                                                                                    }
                                                                                  } else {
                                                                                    Fluttertoast.showToast(msg: "Location are not ready yet.", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.white, textColor: Colors.black, fontSize: 15.0);
                                                                                    // Livelocationfun.instance.startTracking(
                                                                                    //   context: context,
                                                                                    //   onLocationUpdate: (position) {
                                                                                    //     setState(() {
                                                                                    //       doublelat = position.latitude;
                                                                                    //       doublelong = position.longitude;
                                                                                    //       locationMessage = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                                                                    //       log('assigned screen  loceror:$locationMessage');
                                                                                    //     });
                                                                                    //   },
                                                                                    // );
                                                                                    // Show an error message if coordinates are unavailable
                                                                                    print("Location coordinates are not ready yet.");
                                                                                  }
                                                                                }
                                                                              : null,
                                                                          child:
                                                                              Text(
                                                                            'START',
                                                                            style:
                                                                                Theme.of(context).textTheme.displayMedium,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),

                                                                contentPadding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                )
                                              ]),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              ] else ...[
                                FutureBuilder(
                                  future: Future.delayed(const Duration(
                                      seconds: 10)), // Add a delay of 5 seconds
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 200.0),
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    } else {
                                      // After 5 seconds, show the No Data Found image
                                      return Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 200.0),
                                          child: Image.asset(
                                            'assets/errror/no_data_found.png', // Path to your No Data Found image
                                            height: 200,
                                            width: 200,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ]
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future buildQuery(Getbasicinfo val, BuildContext context) async {
    final socDet =
        await SocietyListFunctions.instance.getSocietyDet(val, context);
    final inspStat = socDet?.single.inspStatus ?? '';

    if (inspStat == 1) {
      final actlist = socDet?.single.activity ?? [];
      String selectedIdsString = "[${actlist.join(", ")}]";
      Navigator.of(_scaffoldKey.currentContext!).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ScreenQuery(
            bankname: socDet?.single.socName ?? '',
            branch: socDet?.single.branchName ?? '',
            regNo: socDet?.single.regNo ?? '',
            lastinspdt: socDet?.single.lastInspectionDate ?? '',
            name: socDet?.single.user?.name ?? '',
            role: socDet?.single.user?.roleName ?? '',
            activity: selectedIdsString,
          ),
        ),
      );
    } else {
      Navigator.push(_scaffoldKey.currentContext!, Approutes().basicInfoScreen);
    }
  }
}
