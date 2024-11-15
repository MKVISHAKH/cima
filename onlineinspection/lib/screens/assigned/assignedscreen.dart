import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenAssigned extends StatefulWidget {
  const ScreenAssigned({super.key});

  @override
  State<ScreenAssigned> createState() => _ScreenAssignedState();
}

class _ScreenAssignedState extends State<ScreenAssigned> {
  bool isButtonEnabled = true;
  String locationMessage = 'Current Location of the User';
  String lat = '';
  String long = '';
  Timer? locationTimer;
  int? usrId;
  String? usrName;
  String? time;
  String? date;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestLocationPermission();
      //_startLocationCheckTimer();
      getShareddata();
    });
  }

  Future<void> getShareddata() async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    usrName = sharedValue?.name?.toUpperCase() ?? 'User';
    usrId = sharedValue!.userId;
    // final now = DateTime.now();
    // DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    // date = dateFormat.format(now);

    // String currenttime = dateFormat.add_jm().format(DateTime.now());
    // List<String> substrings = currenttime.split(" ");
    // print(substrings);

    // time = substrings[1];
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

  Future<bool?> popscreen(BuildContext context) async {
    SocietyListFunctions.instance.getScietyListNotifier.value=[];
    Navigator.push(context, Approutes().homescreen);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) async {
            if (!didPop) {
              if (didPop) return;
              await popscreen(context);
            }
            //log('BackButton pressed!');
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    SocietyListFunctions.instance.getScietyListNotifier.value=[];
                    Navigator.pushReplacement(context, Approutes().homescreen);
                  },
                ),
                title: Text(
                  "Assigned Societies",
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
                  child: Text(
                    'Welcome $usrName',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ValueListenableBuilder(
                      valueListenable:
                          SocietyListFunctions.instance.getScietyListNotifier,
                      builder: (BuildContext context, List<Society> newList,Widget? _) {
                        return newList.isEmpty?
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.all(5),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    
                                      color: Theme.of(context).colorScheme.primaryFixed,
                                      shape: BoxShape.circle,
                                      image: const DecorationImage(
                                        image:
                                            AssetImage('assets/errror/no_data_found.png'),
                                        fit: BoxFit.scaleDown,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ):
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
                              child: ExpansionTile(
                                  title: Text(
                                    society.societyName ?? ' ',
                                    style: society.active == true
                                        ? const TextStyle(
                                            color:
                                                Color.fromARGB(255, 3, 99, 54),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: 'Poppins-Medium')
                                        : Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                  ),
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children:
                                              society.branches!.map((subItem) {
                                            String? schDt = subItem.schDate;
                                            DateTime parseDate =
                                                DateFormat("yyyy-MM-dd")
                                                    .parse(schDt ?? '');
                                            var inputDate = DateTime.parse(
                                                parseDate.toString());
                                            var outputFormat =
                                                DateFormat('dd-MM-yyyy');
                                            var schdldt =
                                                outputFormat.format(inputDate);
                                            print(schdldt);
                                            final now = DateTime.now();
                                            DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                                            date = dateFormat.format(now);
                                            print(date);
                                            double? dist = subItem.distance;
                                            
                                            String distance = '';
                                            if (dist == null) {
                                              dist = 0;
                                              distance = '0';
                                              isButtonEnabled = false;
                                            } else if (dist >= 1000) {
                                              double dist1 = dist / 1000;
                                              String myString =
                                                  dist1.toStringAsFixed(1);
                                              distance = "${myString}km";
                                              isButtonEnabled = false;
                                            } else {
                                              if (dist < 20 && schdldt==date) {
                                                isButtonEnabled = true;
                                                String myString =
                                                    dist.toStringAsFixed(1);
                                                distance = "${myString}m";
                                              } else {
                                                isButtonEnabled = false;
                                                String myString =
                                                    dist.toStringAsFixed(1);
                                                distance = "${myString}m";
                                              }
                                            }
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8.0,
                                                      horizontal: 16.0),
                                              child: Card(
                                                // elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .onSecondary),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: ListTile(
                                                    // Main title and subtitle
                                                    title: Text(
                                                      subItem.branchName ?? '',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                    subtitle: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        // Text(items[index].title),
                                                        const SizedBox(
                                                            height: 10),
                                                        Text(
                                                          'Schedule Date: $schdldt',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                        ),
                                                      ],
                                                    ),

                                                    // Leading elevated button with distance
                                                    trailing: Column(
                                                      //mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Container(
                                                          height: 30,
                                                          width: 110,
                                                          decoration:
                                                              BoxDecoration(
                                                            gradient: isButtonEnabled
                                                                ? const LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      Color(
                                                                          0xff5cb85c),
                                                                      Color(
                                                                          0xff5cb85c)
                                                                    ],
                                                                  )
                                                                : const LinearGradient(
                                                                    begin: Alignment
                                                                        .topLeft,
                                                                    end: Alignment
                                                                        .bottomRight,
                                                                    colors: [
                                                                      Colors
                                                                          .grey,
                                                                      Color.fromARGB(
                                                                          255,
                                                                          172,
                                                                          168,
                                                                          168)
                                                                    ],
                                                                  ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12.0),
                                                          ),
                                                          child: Theme(
                                                            data: MyTheme
                                                                .buttonStyleTheme,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed:
                                                                  isButtonEnabled
                                                                      ? () async {
                                                                          if (lat.isNotEmpty &&
                                                                              long.isNotEmpty) {
                                                                            try {
                                                                              double doublelat = double.parse(lat);
                                                                              double doublelong = double.parse(long);

                                                                              final socdet = Getbasicinfo.val(schedulerId: subItem.schedulerId, schedulerDate: subItem.schDate, userId: usrId, socId: society.socId, socName: society.societyName, branchId: subItem.branchId, lattitude: doublelat, longitude: doublelong, bName: subItem.branchName);

                                                                              await SharedPrefManager.instance.setSocietyinfo(socdet);

                                                                              buildQuery(socdet);
                                                                            } catch (e) {
                                                                              // Handle parsing error, e.g., show a message to the user
                                                                              print("Failed to parse coordinates: $e");
                                                                            }
                                                                          } else {
                                                                            // Show an error message if coordinates are unavailable
                                                                            print("Location coordinates are not ready yet.");
                                                                          }
                                                                        }
                                                                      : null,
                                                              child: Text(
                                                                'START',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleMedium,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 8),
                                                        Text(
                                                          'Distance: $distance',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                        ),
                                                      ],
                                                    ),

                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            16),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )
                                  ]),
                            );
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future buildQuery(Getbasicinfo val) async {
    SocietyListFunctions.instance.getSocietyDet(val);

    Navigator.push(context, Approutes().basicInfoScreen);
  }
}
