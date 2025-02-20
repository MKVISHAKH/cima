import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenActionRprt extends StatefulWidget {
  const ScreenActionRprt({super.key});

  @override
  State<ScreenActionRprt> createState() => _ScreenCmpltdRprtState();
}

class _ScreenCmpltdRprtState extends State<ScreenActionRprt> {
  List<String> columns = [];
  List<String?> cells = [];

  int? selectedSocietyid;
  int? selectedBranchid;
  List<DatumUser>? soclist = [];
  List<Map<String, Object>> societylst = [];
  List<DatumBranch>? branchlst = [];
  List<Map<String, Object>> branchlist = [];
  String cmpltdt = '';
  DatumVal? socdet;
  String inspecDt = '';
  String apprvDt = '';
  String notDt = '';
  //Map<String, int> socIdMap = {};
  String? extractedString;
  final TextEditingController _dateToController = TextEditingController();
  final TextEditingController _dateFromController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      soclist = await SocietyListFunctions.instance.getSocietyUser(context);
      setState(() {
        societylst = soclist!.map((bus) {
          String societyname = bus.societyName ?? "";
          return {
            'socid': bus.socId!, // routeId as int
            'socname': societyname, // Display label
          };
        }).toList();
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
                  icon: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, Approutes().homescreen);
                  },
                ),
                title: Text(
                  "Actions",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                )),
            body: Column(
              //children: [ScrollableWidget(child: buildScheduledTab())],
              children: [
                inputfiledDisplay(),
                Expanded(child: ScrollableWidget(child: buildScheduledTab())),
              ],
            )),
      ),
    );
  }

  Widget buildScheduledTab() {
    return ValueListenableBuilder(
        valueListenable: SchedulelistFun.instance.getActionRprtNotifier,
        builder: (BuildContext context, List<DatumVal> newList, Widget? _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 3),
              if (newList.isNotEmpty) ...[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.onSecondary),
                    //borderRadius:const BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                  ),
                  child: DataTable(
                    headingRowHeight: 35,
                    dataRowMaxHeight: 35,
                    dataRowMinHeight: 35,
                    headingRowColor:
                        WidgetStateProperty.all(const Color(0xff1569C7)),
                    columns: getColumns(columns = [
                      'SI.No',
                      'Society',
                      'Branch',
                      'Inspection Date',
                      'Status',
                      //'Action',
                      'Remarks',
                      ''
                    ]),
                    rows: getRows(newList, context),
                  ),
                ),
              ] else ...[
                FutureBuilder(
                  future: Future.delayed(
                      const Duration(seconds: 10)), // Add a delay of 5 seconds
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 100.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      // After 5 seconds, show the No Data Found image
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 100.0),
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
        });
  }

  Widget inputfiledDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
      decoration: const BoxDecoration(
        color: Color(0xff1569C7),
      ),
      child: Theme(
        data: MyTheme.googleFormTheme,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('From Date',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(right: 105.0),
                  child: Text('To Date',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      2.2, // Adjust width if needed
                  //height: MediaQuery.of(context).size.height/20, // Adjust width if needed
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary, // Background color
                      borderRadius: BorderRadius.circular(
                          6.0), // Optional rounded corners
                    ),
                    child: TextFormField(
                      controller: _dateFromController,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 12),
                      decoration: InputDecoration(
                          hintText: 'From Date',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontSize: 12),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12)),
                      readOnly: true,
                      onTap: () => _selectDate(context, _dateFromController),
                    ),
                  ),
                ),
                //const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width /
                      2.2, // Adjust width if needed
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary, // Background color
                      borderRadius: BorderRadius.circular(
                          6.0), // Optional rounded corners
                    ),
                    child: TextFormField(
                      controller: _dateToController,
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 12),
                      decoration: InputDecoration(
                          hintText: 'To Date',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(fontSize: 12),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12)),
                      readOnly: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 238.0),
              child: Text('Select Society',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              //width: MediaQuery.of(context).size.width / 1.5,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary, // Background color
                  borderRadius:
                      BorderRadius.circular(6.0), // Optional rounded corners
                ),
                child: DropdownButtonFormField<int>(
                  items: societylst.map((soc) {
                    return DropdownMenuItem<int>(
                      value: soc['socid'] as int, // Use socid as the value
                      child: Text(
                        soc['socname'] as String,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedSocietyid = newValue; // Store the selected socid
                    });
                    fetchbranch(
                        selectedSocietyid); // Call API with the selected ID
                  },
                  value: selectedSocietyid, // Pre-selected value if any
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Select Society',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 12),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12)),
                  dropdownColor: Theme.of(context).colorScheme.onPrimary,
                  validator: (value) {
                    if (value == null) {
                      return 'Select Society';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(right: 238.0),
              child: Text('Select Branch',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            //branch
            SizedBox(
              //width: MediaQuery.of(context).size.width / 1.9,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary, // Background color
                  borderRadius:
                      BorderRadius.circular(6.0), // Optional rounded corners
                ),
                child: DropdownButtonFormField<int>(
                  items: branchlist.map((branch) {
                    return DropdownMenuItem<int>(
                      value:
                          branch['branch_id'] as int, // Use socid as the value
                      child: Text(
                        branch['branch_name'] as String,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(fontSize: 12),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedBranchid = newValue; // Store the selected socid
                    });
                    // fetchbranch(
                    //     selectedBranchid); // Call API with the selected ID
                  },
                  value: selectedBranchid, // Pre-selected value if any
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  decoration: InputDecoration(
                      hintText: 'Select Branch',
                      hintStyle:
                          Theme.of(context).textTheme.displaySmall?.copyWith(
                                fontSize: 12,
                              ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12)),
                  dropdownColor: Theme.of(context).colorScheme.onPrimary,
                  validator: (value) {
                    if (value == null) {
                      return 'Select Branch';
                    }
                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            //button
            Container(
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
                    SchedulelistFun.instance.getActionRprt1(
                        selectedBranchid,
                        selectedSocietyid,
                        _dateFromController.text,
                        _dateToController.text,
                        context);
                  },
                  child: Text(
                    'GET',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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

  List<DataRow> getRows(List<DatumVal> newList, BuildContext context) {
    String? status;
    //String? action;
    String? remarks;
    return newList.asMap().entries.map((entry) {
      int index = entry.key + 1; // Auto-increment starting from 1
      DatumVal task = entry.value;

      String? cmpDt = task.inspecDate;
      if (cmpDt == null) {
        cmpltdt = '';
      } else {
        DateTime parseDate = DateFormat("yyyy-MM-dd").parse(cmpDt);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd-MM-yyyy');
        cmpltdt = outputFormat.format(inputDate);
      }

      if (task.noticeStatus == 1) {
        status = 'Notice Generated';
        //action = task.noticeGenBy;
        remarks = task.noticeRemarks;
      } else {
        status = 'Approved';
        //action = task.approveBy;
        remarks = task.remarks;
      }
      cells = [
        index.toString(),
        task.socName,
        task.branchName,
        cmpltdt,
        status,
        // action,
        remarks
      ];
      final reasonColors = {
        'Approved': const Color.fromARGB(255, 8, 92, 238),
        'Notice Generated': const Color.fromARGB(255, 7, 106, 10),
      };
      Color rowColor = index % 2 == 0
          ? const Color.fromARGB(255, 200, 227, 245) // Light grey for even rows
          : const Color(0Xff95B9C7); // White for odd rows

      return DataRow(color: WidgetStateProperty.all(rowColor), cells: [
        ...Utils.modelBuilder(cells, (index, cell) {
          //final taskbold = index == 1;
          final taskbold = index == 4;
          return DataCell(
            Text(
              '$cell',
              style: taskbold
                  ? Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: reasonColors[status], fontWeight: FontWeight.bold)
                  : Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          );
        }),
        task.noticeStatus == 1
            ? DataCell(
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
                          SchedulelistFun.instance
                              .noticeViewList(task.inspId, context);

                          showModalBottomSheet(
                              enableDrag: true,
                              isDismissible: false,
                              isScrollControlled: true,
                              backgroundColor: const Color(0xff98c1d9),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              )),
                              context: context,
                              builder: (context) => buildSheet());
                          // final inspId = task.inspId;

                          // openFile(task);
                        },
                        child: Text(
                          'VIEW',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : DataCell(Center(
                child: Text(
                "Processing",
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: const Color.fromARGB(255, 210, 127, 2),
                    fontWeight: FontWeight.bold),
              )))
      ]);
    }).toList();
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        // controller.text = "${picked.toLocal()}".split(' ')[0];
        DateTime fromDate = picked;
        controller.text = DateFormat('dd-MM-yyyy').format(fromDate);
        DateTime toDate = picked.add(const Duration(days: 30));
        _dateToController.text = DateFormat('dd-MM-yyyy').format(toDate);
        //_dateToController.text = DateFormat('yyyy-MM-dd').format(toDate);
      });
    }
  }

  fetchbranch(int? socid) async {
    //print(socid);
    branchlst = await SocietyListFunctions.instance.fetchBranch(socid, context);
    setState(() {
      branchlist = branchlst!.map((branch) {
        String branchname = branch.branchName ?? "";
        return {
          'branch_id': branch.branchId!, // routeId as int
          'branch_name': branchname, // Display label
        };
      }).toList();
    });
  }

  Widget buildSheet() {
    // width: MediaQuery.of(context).size.width,
    //height: MediaQuery.of(context).size.height/2,
    return ClipRRect(
     borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
     child: ValueListenableBuilder(
         valueListenable: SchedulelistFun.instance.noticeListNotifierNotifier,
         builder:
             (BuildContext context, List<DatumVal> noticeList, Widget? _) {
           return ListView.builder(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: noticeList.length,
               itemBuilder: (context, index) {
                 final inspdet = noticeList[index];
                 final inspdate = inspdet.inspecDate;
                 final apprvDate = inspdet.approveDate;
                 final notDate = inspdet.noticeDate;
                 if (inspdate == null) {
                   inspecDt = '';
                 } else {
                   DateTime parseDate =
                       DateFormat("yyyy-MM-dd HH:mm:ss").parse(inspdate);
                   var inputDate = DateTime.parse(parseDate.toString());
                   var outputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
                   inspecDt = outputFormat.format(inputDate);
                   print(inspecDt);
                 }
                 if (apprvDate == null) {
                   apprvDt = '';
                 } else {
                   DateTime parseDate =
                       DateFormat("yyyy-MM-dd HH:mm:ss").parse(apprvDate);
                   var inputDate = DateTime.parse(parseDate.toString());
                   var outputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
                   apprvDt = outputFormat.format(inputDate);
                   print(apprvDt);
                 }
                 if (notDate == null) {
                   notDt = '';
                 } else {
                   DateTime parseDate =
                       DateFormat("yyyy-MM-dd HH:mm:ss").parse(notDate);
                   var inputDate = DateTime.parse(parseDate.toString());
                   var outputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
                   notDt = outputFormat.format(inputDate);
                   print(notDt);
                 }
                 return Container(
                     decoration: BoxDecoration(
                       color: Colors.white,
                       border: Border.all(
                           color: Theme.of(context).colorScheme.onSecondary),
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(0.0),
                       child: Column(
                         //mainAxisSize: MainAxisSize.min,
                         children: [
                           const SizedBox(height: 10),
                           Text('INSPECTION REPORT',
                               style: Theme.of(context).textTheme.bodyLarge),
                           const SizedBox(height: 10),
                           Card(
                             elevation: 3,
                             margin: const EdgeInsets.symmetric(
                               vertical: 2,
                               horizontal: 2,
                             ),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(12),
                             ),
                             child: Container(
                               width: MediaQuery.of(context).size.width,
                               decoration: BoxDecoration(
                                 color: Colors.white, // White background
                                 borderRadius: BorderRadius.circular(
                                     12), // Rounded corners
                                 border: Border.all(
                                   // Thin black border
                                   color: Colors.black,
                                   width: 1,
                                 ),
                               ),
                               padding: const EdgeInsets.all(
                                   10), // Optional padding
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment
                                     .start, // Align text to the start
                                 children: [
                                   Row(
                                     children: [
                                       Text(
                                         "Society Name : ",
                                         // maxLines: 2, // Or any number you want
                                         // overflow: TextOverflow.visible,
                                         // softWrap: true,
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           '${noticeList.first.socName}',
                                           // maxLines: 2, // Or any number you want
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Branch : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           "${noticeList.first.branchName}",
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Inspected By : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           "${noticeList.first.inspectedBy}",
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Inspected Date : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           inspecDt,
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Approved By : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           noticeList.first.approveBy ?? '',
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Approved Date : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           apprvDt,
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Remarks : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           "${noticeList.first.remarks}",
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Notice Generated By : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           noticeList.first.noticeGenBy ?? '',
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                   const SizedBox(
                                     height: 5,
                                   ),
                                   Row(
                                     children: [
                                       Text(
                                         "Notice Generated Date : ",
                                         style: Theme.of(context)
                                             .textTheme
                                             .bodyLarge
                                             ?.copyWith(
                                               fontSize: 14,
                                             ),
                                       ),
                                       Flexible(
                                         child: Text(
                                           notDt,
                                           overflow: TextOverflow.visible,
                                           softWrap: true,
                                           style: Theme.of(context)
                                               .textTheme
                                               .bodyLarge
                                               ?.copyWith(
                                                   fontSize: 14,
                                                   fontWeight:
                                                       FontWeight.normal),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ),
                           // ScrollableWidget(child: inputfiledDisplay()),
                           const SizedBox(height: 5),
                           ScrollableWidget(
                             child: Card(
                               elevation: 3,
                               margin: const EdgeInsets.symmetric(
                                 vertical: 2,
                                 horizontal: 2,
                               ),
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(12),
                               ),
                               child: Container(
                                 //width: MediaQuery.of(context).size.width,
                                 decoration: BoxDecoration(
                                   color: Colors.white, // White background
                                   borderRadius: BorderRadius.circular(
                                       12), // Rounded corners
                                   border: Border.all(
                                     // Thin black border
                                     color: Colors.black,
                                     width: 1,
                                   ),
                                 ),
                                 padding: const EdgeInsets.all(10),
                                 child: Column(
                                   children: [
                                     DataTable(
                                       headingRowHeight: 35,
                                       dataRowMaxHeight: 35,
                                       dataRowMinHeight: 35,
                                       headingRowColor:
                                           WidgetStateProperty.all(
                                               const Color(0xff1569C7)),
                                       columns: getColumns(columns = [
                                         'SI.No',
                                         'Type',
                                         'Notice No',
                                         ''
                                       ]),
                                       rows: getRowsList(noticeList, context),
                                     ),
                                     const SizedBox(
                                       height: 20,
                                     ),
                                     Container(
                                       height: 30,
                                       width: 100,
                                       decoration: BoxDecoration(
                                         gradient: LinearGradient(
                                           begin: Alignment.topLeft,
                                           end: Alignment.bottomRight,
                                           colors: [
                                             Theme.of(context)
                                                 .colorScheme
                                                 .primary,
                                             Theme.of(context)
                                                 .colorScheme
                                                 .primary
                                           ],
                                         ),
                                         borderRadius:
                                             BorderRadius.circular(12.0),
                                       ),
                                       child: Theme(
                                         data: MyTheme.buttonStyleTheme,
                                         child: ElevatedButton(
                                           onPressed: () async {
                                             // final inspId = task.inspId;
                                             Navigator.pop(context);
                                             // Navigator.push(context, Approutes().screensActionRprt);
          
                                             //openFile(task,context);
                                           },
                                           child: Text(
                                             'Back',
                                             style: Theme.of(context)
                                                 .textTheme
                                                 .displayMedium,
                                           ),
                                         ),
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                           ),
                         ],
                       ),
                     ));
               }
          
               //socdet=noticeList.single,
          
               );
         }),
          );
  }

  List<DataRow> getRowsList(List<DatumVal> noticeList, BuildContext context) {
    // String? status;
    // String? action;
    // String? remarks;
    return noticeList.first.notice!.asMap().entries.map((entry) {
      int index = entry.key + 1; // Auto-increment starting from 1
      Notice task = entry.value;

      cells = [
        index.toString(),
        task.reason,
        task.description,
      ];
      final reasonColors = {
        'SHO': const Color.fromARGB(255, 174, 15, 3),
        'SERIOUS': const Color.fromARGB(255, 235, 78, 117),
        'MILD': Color.fromARGB(255, 11, 114, 14),
        'MEDIUM': Colors.orange,
        'DEMAND NOTICE': Colors.purple,
      };
      Color rowColor = index % 2 == 0
          ? const Color.fromARGB(255, 200, 227, 245) // Light grey for even rows
          : const Color(0Xff95B9C7); // White for odd rows

      return DataRow(color: WidgetStateProperty.all(rowColor), cells: [
        ...Utils.modelBuilder(cells, (index, cell) {
          final taskbold = index == 1;

          return DataCell(
            Text(
              '$cell',
              style: taskbold
                  ? Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: reasonColors[task.reason],
                      fontWeight: FontWeight.bold)
                  : Theme.of(context).textTheme.displaySmall,
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

                    openFile(task, context);
                  },
                  child: Text(
                    'NOTICE',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]);
    }).toList();
  }

  Future openFile(Notice task, BuildContext context) async {
    final file = await dwnloadFile(task, context);
    if (file == null) {
      Fluttertoast.showToast(
          msg: "No Data Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      OpenFile.open(file.path);
    }
  }

  Future<File?> dwnloadFile(Notice task, BuildContext context) async {
    try {
      final dwnldresp = await Ciadata().dwnldNotice(task.fileurl);
      RegExp regExp = RegExp(r"/([^/]+)\.pdf$");
  
          // Extracting the match
          Match? match = regExp.firstMatch(task.fileurl??'');
          //String extractedString;
          if (match != null) {
             extractedString = match.group(1)!;
            print(extractedString); // Output: 52_NOTI_3211_2025
          } else {
            print("No match found");
          }
      if (dwnldresp == null) {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "No Data Found");
      } else if (dwnldresp.statusCode == 200) {
        Random random = Random();
        int random3digit = 100 + random.nextInt(900);
        var now = DateTime.now();
        DateFormat dateFormat = DateFormat("dd-MM-yyyy");
        String datenow = dateFormat.format(now);
        String name = "${extractedString}_${datenow}_$random3digit.pdf";

        final appStorage = await getApplicationDocumentsDirectory();
        final file = File('${appStorage.path}/$name');

        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(dwnldresp.data);
        await raf.close();
        return file;
      } else if (dwnldresp.statusCode == 500) {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (dwnldresp.statusCode == 408) {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "No Data Found");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }
}
