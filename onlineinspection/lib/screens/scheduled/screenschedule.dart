import 'dart:developer';

import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenScheduled extends StatefulWidget {
  const ScreenScheduled({super.key});

  @override
  State<ScreenScheduled> createState() => _ScreenScheduledState();
}

class _ScreenScheduledState extends State<ScreenScheduled> {
  List<String> columns = [];
  List<String?> cells = [];
  String locationMessage = 'Current Location of the User';
  Timer? locationTimer;
  double doublelat = 0;
  double doublelong = 0;
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

  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
                    Navigator.pushReplacement(context, Approutes().homescreen);
                  },
                ),
                title: Text(
                  "Schedule Details",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
            body: Column(
              children: [
                Expanded(child: ScrollableWidget(child: buildScheduledTab()))
              ],
            )),
      ),
    );
  }

  Widget buildScheduledTab() {
    return ValueListenableBuilder(
        valueListenable: SchedulelistFun.instance.getScheduleListNotifier,
        builder: (BuildContext context, List<DatumVal> newList, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (newList.isNotEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DataTable(
                    dataRowMaxHeight: 35,
                    dataRowMinHeight: 35,
                    headingRowHeight: 35,
                    headingRowColor:
                        WidgetStateProperty.all(const Color(0xff1569C7)),
                    columns: getColumns(columns = [
                      'Sl.No',
                      'Sch.Date ',
                      'Society Name',
                      'Branch',
                      'Status',
                      '',
                      ''
                    ]),
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

  List<DataRow> getRows(List<DatumVal> newList) {
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Auto-increment starting from 1
      DatumVal task = entry.value;

      String? schDt = task.schDate;
      DateTime parseDate = DateFormat("yyyy-MM-dd").parse(schDt ?? '');
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('dd-MM-yyyy');
      var schdldt = outputFormat.format(inputDate);
      //print(schdldt);
      Color rowColor = index % 2 == 0
          // Light grey for even rows
          ? const Color.fromARGB(255, 200, 227, 245) // Light grey for even rows
          : const Color(0Xff95B9C7);

      cells = [
        index.toString(),
        schdldt,
        task.socName,
        task.branchName,
        task.reqStatus
      ];
      final reasonColors = {
        'Scheduled': const Color.fromARGB(255, 8, 92, 238),
        'Req Rejected': Colors.red,
        'Req Approved': Colors.green,
        'Requested': const Color.fromARGB(255, 206, 124, 1),
        'Started': Colors.purple,
      };

      return DataRow(color: WidgetStateProperty.all(rowColor), cells: [
        ...Utils.modelBuilder(cells, (index, cell) {
          final taskbold = index == 4;

          return DataCell(
            Text(
              '$cell',
              style: taskbold
                  ? Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: reasonColors[task.reqStatus],
                      fontWeight: FontWeight.bold)
                  : Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          );
        }),
        DataCell(
          Center(
              child: IconButton(
                  onPressed: () {
                    task.geoLocationupdt == 0
                        ? addlocationbox(task, context)
                        : locationuptodatebox(context);
                  },
                  icon: task.geoLocationupdt == 0
                      ? Icon(Icons.location_off_rounded,
                          size: 20, color: Colors.red[600])
                      : Icon(Icons.location_on_rounded,
                          size: 20, color: Colors.green[600]))),
        ),
        DataCell(
          Center(
            child: Container(
              height: 30,
              width: 135,
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
                    //Navigator.push(context, Approutes().screenschdlReq);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenSchdlReq(
                          bankName: task.socName,
                          branch: task.branchName,
                          inspDt: schdldt,
                          schdlId: task.schedulerId,
                          socId: task.socId,
                          brId: task.branchId,
                          reqStatus: task.reqStatus,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'RESCHEDULE',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 13),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);
    }).toList();
  }

  Future addlocationbox(DatumVal task, BuildContext context) async =>
      showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                title: Column(
                  children: [
                    Center(
                        child: Text("NO LOCATION AVAILABLE",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[600]))),
                  const  SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text("Please Update Society Location",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(color: Colors.white))),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      addGeoloc(task, context);
                    },
                    child: Text('Update Location',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Back',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                ],
              ));
  Future locationuptodatebox(BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            title: Center(
                child: Text("Location is UptoDate",
                    style: Theme.of(context).textTheme.titleSmall)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Back',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ));
  addGeoloc(DatumVal task, BuildContext context) async {
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
      await Livelocationfun.instance
          .updateLocation(locReq, context, scSchdlLoc);

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
            //log('query screen strtque loc_not_ready:$locationMessage');
          });
        },
      );
    }
  }
}
