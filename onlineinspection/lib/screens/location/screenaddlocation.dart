import 'dart:developer';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenAddLocation extends StatefulWidget {
  const ScreenAddLocation({
    super.key,
  });

  @override
  State<ScreenAddLocation> createState() => _ScreenAddLocationState();
}

class _ScreenAddLocationState extends State<ScreenAddLocation> {
  int? selectedSocietyid;
  int? selectedBranchid;
  List<DatumUser>? soclist = [];
  List<Map<String, Object>> societylst = [];
  List<DatumBranch>? branchlst = [];
  List<Map<String, Object>> branchlist = [];
  //final _formkey = GlobalKey<FormState>();
  String locationMessage = 'Current Location of the User';
  Timer? locationTimer;
  double doublelat = 0;
  double doublelong = 0;
  List<String> columns = [];
  List<String?> cells = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // fetchSociety();

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
    //fetchBusregistraionList();
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.push(context, Approutes().homescreen);
    return true;
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
            if (!didPop) {
              if (didPop) return;
              await popscreen(context);
            }
            log('BackButton pressed!');
          },
          child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primaryFixed,
              appBar: AppBar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, Approutes().homescreen);
                    },
                  ),
                  title: Text(
                    "Map Geolocation",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )),
              body: Column(
                children: [
                  // inputfiledDisplay(),
                  Expanded(child: ScrollableWidget(child: buildScheduledTab())),
                ],
              )),
        ));
  }

  Widget buildScheduledTab() {
    return ValueListenableBuilder(
        valueListenable: Livelocationfun.instance.getLocationUpdtListNotifier,
        builder: (BuildContext context, List<DatumValue> newList, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ScrollableWidget(child: inputfiledDisplay()),
              //const SizedBox(height: 5),
              if (newList.isNotEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary),
                    //borderRadius:const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                  ),
                  child: DataTable(
                    dataRowMaxHeight: 35,
                    dataRowMinHeight: 35,
                    headingRowHeight: 35,
                    headingRowColor:
                        WidgetStateProperty.all(const Color(0xff1569C7)),
                    columns: getColumns(
                        columns = ['SI.No', 'Society Name', 'Branch', '']),
                    rows: getRows(newList),
                  ),
                ),
              ] else ...[
                FutureBuilder(
                  future: Future.delayed(
                      const Duration(seconds: 10)), // Add a delay of 5 seconds
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 2.5,
                          horizontal: MediaQuery.of(context).size.width / 2.3,
                        ),
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      // After 5 seconds, show the No Data Found image
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 3.5,
                          horizontal: MediaQuery.of(context).size.width / 4,
                        ),
                        child: Image.asset(
                          'assets/errror/no_data_found.png', // Path to your No Data Found image
                          height: 200,
                          width: 200,
                        ),
                      );
                    }
                  },
                ),
              ]
            ],
          );
        });
  }

  List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Center(
          child: Text(
            column,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins-Medium',
                fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<DatumValue> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Auto-increment starting from 1
      DatumValue task = entry.value;

      cells = [
        index.toString(),
        task.socName,
        task.branchName,
      ];
      Color rowColor = index % 2 == 0
          ? const Color.fromARGB(255, 200, 227, 245) // Light grey for even rows
          : const Color(0Xff95B9C7); // White for odd rows

      return DataRow(color: WidgetStateProperty.all(rowColor), cells: [
        ...Utils.modelBuilder(cells, (index, cell) {
          //final taskbold = index == 1;

          return DataCell(
            Text(
              '$cell',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          );
        }),
        DataCell(
          Center(
            child: Container(
              height: 30,
              width: 120,
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
                    // final inspId = task.inspId;
                    warningBox(task, context);
                    // openFile(task,context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'MAP',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const Icon(
                        Icons.location_on_sharp,
                        size: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);
    }).toList();
  }
Future warningBox(task,BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            title: Center(
                child: Text("Do You want to Update Geolocation?",
                    style: Theme.of(context).textTheme.titleSmall)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => Navigator.pop(context),
                child: Text('NO',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  addGeoloc(task, context);
                },
                child: Text('YES',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ));

  addGeoloc(DatumValue task, BuildContext context) async {
    if (doublelat != 0 && doublelong != 0) {
      final userval = await SharedPrefManager.instance.getSharedData();

      final locReq = QuestionReq(
        userId: userval!.userId,
        socId: task.socId,
        branchId: task.branchId,
        lattitude: doublelat,
        longitude: doublelong,
      );
      if (!context.mounted) return;
      await Livelocationfun.instance.updateLocation(locReq, context, scAddLoc);
      
      if (!context.mounted) return;

      Navigator.of(context).pop();

    } else {
      Livelocationfun.instance.startTracking(
        context: context,
        onLocationUpdate: (position) {
          setState(() {
            doublelat = position.latitude;
            doublelong = position.longitude;
            locationMessage =
                'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
            log('query screen strtque loc_not_ready:$locationMessage');
          });
        },
      );
    }
  }
}
