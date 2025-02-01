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

  // Widget inputfiledDisplay() {
  //   return Container(
  //     // height: MediaQuery.of(context).size.height/2.6 ,
  //     padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
  //     decoration: const BoxDecoration(
  //       color: Color(0xff1569C7),
  //     ),
  //     child: Theme(
  //       data: MyTheme.googleFormTheme,
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           const SizedBox(height: 10),
  //           Text('District',
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .labelMedium
  //                   ?.copyWith(fontWeight: FontWeight.bold)),
  //           SizedBox(
  //             //width: MediaQuery.of(context).size.width / 1.5,
  //             child: Container(
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context)
  //                     .colorScheme
  //                     .onPrimary, // Background color
  //                 borderRadius:
  //                     BorderRadius.circular(6.0), // Optional rounded corners
  //               ),
  //               child: DropdownButtonFormField<int>(
  //                 items: societylst.map((soc) {
  //                   return DropdownMenuItem<int>(
  //                     value: soc['socid'] as int, // Use socid as the value
  //                     child: Text(
  //                       soc['socname'] as String,
  //                       style: Theme.of(context)
  //                           .textTheme
  //                           .displaySmall
  //                           ?.copyWith(fontSize: 12),
  //                     ),
  //                   );
  //                 }).toList(),
  //                 onChanged: (int? newValue) {
  //                   setState(() {
  //                     selectedSocietyid = newValue; // Store the selected socid
  //                   });
  //                   fetchbranch(selectedSocietyid,
  //                       context); // Call API with the selected ID
  //                 },
  //                 value: selectedSocietyid, // Pre-selected value if any
  //                 style: TextStyle(
  //                   color: Theme.of(context).colorScheme.onPrimary,
  //                 ),
  //                 icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
  //                 decoration: InputDecoration(
  //                     hintText: 'Select District',
  //                     hintStyle: Theme.of(context)
  //                         .textTheme
  //                         .displaySmall
  //                         ?.copyWith(fontSize: 12),
  //                     contentPadding: const EdgeInsets.symmetric(
  //                         vertical: 10, horizontal: 12)),
  //                 dropdownColor: Theme.of(context).colorScheme.onPrimary,
  //                 validator: (value) {
  //                   if (value == null) {
  //                     return 'Select District';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           Text('Taluk',
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .labelMedium
  //                   ?.copyWith(fontWeight: FontWeight.bold)),
  //           //branch
  //           SizedBox(
  //             //width: MediaQuery.of(context).size.width / 1.9,
  //             child: Container(
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context)
  //                     .colorScheme
  //                     .onPrimary, // Background color
  //                 borderRadius:
  //                     BorderRadius.circular(6.0), // Optional rounded corners
  //               ),
  //               child: DropdownButtonFormField<int>(
  //                 items: branchlist.map((branch) {
  //                   return DropdownMenuItem<int>(
  //                     value:
  //                         branch['branch_id'] as int, // Use socid as the value
  //                     child: Text(
  //                       branch['branch_name'] as String,
  //                       style: Theme.of(context)
  //                           .textTheme
  //                           .displaySmall
  //                           ?.copyWith(fontSize: 12),
  //                     ),
  //                   );
  //                 }).toList(),
  //                 onChanged: (int? newValue) {
  //                   setState(() {
  //                     selectedBranchid = newValue; // Store the selected socid
  //                   });
  //                   // fetchbranch(
  //                   //     selectedBranchid); // Call API with the selected ID
  //                 },
  //                 value: selectedBranchid, // Pre-selected value if any
  //                 style: TextStyle(
  //                   color: Theme.of(context).colorScheme.onPrimary,
  //                 ),
  //                 icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
  //                 decoration: InputDecoration(
  //                     hintText: 'Select Taluk',
  //                     hintStyle:
  //                         Theme.of(context).textTheme.displaySmall?.copyWith(
  //                               fontSize: 12,
  //                             ),
  //                     contentPadding: const EdgeInsets.symmetric(
  //                         vertical: 10, horizontal: 12)),
  //                 dropdownColor: Theme.of(context).colorScheme.onPrimary,
  //                 validator: (value) {
  //                   if (value == null) {
  //                     return 'Select Taluk';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 10),
  //           Text('Unit',
  //               style: Theme.of(context)
  //                   .textTheme
  //                   .labelMedium
  //                   ?.copyWith(fontWeight: FontWeight.bold)),
  //           //branch
  //           SizedBox(
  //             //width: MediaQuery.of(context).size.width / 1.9,
  //             child: Container(
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 color: Theme.of(context)
  //                     .colorScheme
  //                     .onPrimary, // Background color
  //                 borderRadius:
  //                     BorderRadius.circular(6.0), // Optional rounded corners
  //               ),
  //               child: DropdownButtonFormField<int>(
  //                 items: branchlist.map((branch) {
  //                   return DropdownMenuItem<int>(
  //                     value:
  //                         branch['branch_id'] as int, // Use socid as the value
  //                     child: Text(
  //                       branch['branch_name'] as String,
  //                       style: Theme.of(context)
  //                           .textTheme
  //                           .displaySmall
  //                           ?.copyWith(fontSize: 12),
  //                     ),
  //                   );
  //                 }).toList(),
  //                 onChanged: (int? newValue) {
  //                   setState(() {
  //                     selectedBranchid = newValue; // Store the selected socid
  //                   });
  //                   // fetchbranch(
  //                   //     selectedBranchid); // Call API with the selected ID
  //                 },
  //                 value: selectedBranchid, // Pre-selected value if any
  //                 style: TextStyle(
  //                   color: Theme.of(context).colorScheme.onPrimary,
  //                 ),
  //                 icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
  //                 decoration: InputDecoration(
  //                     hintText: 'Select Unit',
  //                     hintStyle:
  //                         Theme.of(context).textTheme.displaySmall?.copyWith(
  //                               fontSize: 12,
  //                             ),
  //                     contentPadding: const EdgeInsets.symmetric(
  //                         vertical: 10, horizontal: 12)),
  //                 dropdownColor: Theme.of(context).colorScheme.onPrimary,
  //                 validator: (value) {
  //                   if (value == null) {
  //                     return 'Select Unit';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 15),
  //           //button
  //           Center(
  //             child: Container(
  //               height: 30,
  //               width: 120,
  //               decoration: BoxDecoration(
  //                 gradient: LinearGradient(
  //                   begin: Alignment.topLeft,
  //                   end: Alignment.bottomRight,
  //                   colors: [
  //                     Theme.of(context).colorScheme.primary,
  //                     Theme.of(context).colorScheme.primary
  //                   ],
  //                 ),
  //                 borderRadius: BorderRadius.circular(12.0),
  //               ),
  //               child: Theme(
  //                 data: MyTheme.buttonStyleTheme,
  //                 child: ElevatedButton(
  //                   onPressed: () async {
  //                     // SchedulelistFun.instance.getSchdlcmpltLst1(
  //                     //     selectedBranchid,
  //                     //     selectedSocietyid,
  //                     //     // _dateFromController.text,
  //                     //     // _dateToController.text,
  //                     //     context);
  //                   },
  //                   child: Text(
  //                     'SEARCH',
  //                     style: Theme.of(context).textTheme.displayMedium,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

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
                    addGeoloc(task, context);
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
      Livelocationfun.instance.updateLocation(locReq, context, scAddLoc);
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
