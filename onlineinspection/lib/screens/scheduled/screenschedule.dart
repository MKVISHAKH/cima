
import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/functions/schedule/scheduleListFun.dart';
import 'package:onlineinspection/model/schedule/schedul_lst_resp/datum.dart';
import 'package:onlineinspection/widgets/scrollablewidget/scrollableWidget.dart';
import 'package:onlineinspection/widgets/utils/utils.dart';


class ScreenScheduled extends StatefulWidget {
  const ScreenScheduled({super.key});

  @override
  State<ScreenScheduled> createState() => _ScreenScheduledState();
}

class _ScreenScheduledState extends State<ScreenScheduled> {
  // @override
  // void initState(){
  //   super.initState();
  // }
  List<String> columns = [];
  List<String?> cells = [];
   Future<bool?> popscreen(BuildContext context) async {
    //selectedItems.value = {0};
    Navigator.push(context, Approutes().homescreen);
    return true;
  }
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return PopScope(
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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(context, Approutes().homescreen);
                },
              ),
              title: Text(
                "Schedule Details",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              )),
          body: ListView(
            children: [
              ScrollableWidget(child: buildScheduledTab())
            ],
          )),
    );
  }
Widget buildScheduledTab(){
  return ValueListenableBuilder(
    valueListenable: SchedulelistFun.instance.getScheduleListNotifier,
     builder: (BuildContext context, List<DatumVal> newList, Widget? _) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          
        children: [
        DataTable(
              columns: getColumns(columns = [
                'S.No',
                'Scoieyty Name',
                'Branch',
                'Sch.Date ',
                ''
              ]),
              rows: getRows(newList),
            ),
                ],
              ),
            );
     });
}
List<DataColumn> getColumns(List<String> columns) {
    return columns.map((String column) {
      return DataColumn(
        label: Expanded(
          child: Center(
            child: Text(
              column,
              style:const TextStyle(
            color: Color.fromARGB(255, 15, 98, 240),
            fontSize: 16,
            fontFamily: 'Poppins-Medium',
            fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<DataRow> getRows(List<DatumVal> newList) {
    return newList.asMap().entries.map((entry) {
    int index = entry.key + 1; // Auto-increment starting from 1
    DatumVal task = entry.value;

    String? schDt =task.schDate;                                                      
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(schDt ?? '');
    var inputDate =  DateTime.parse(parseDate.toString());
    var outputFormat =DateFormat('dd-MM-yyyy');
    var schdldt = outputFormat.format(inputDate);
    //print(schdldt);
    cells = [
          index.toString(),
          task.socName,
          task.branchName,
          schdldt,
        ];

        return DataRow(cells: [
          ...Utils.modelBuilder(cells, (index, cell) {
            //final taskbold = index == 1;
            

            return DataCell(
              Center(
                child: Text('$cell',
                    style: 
                         Theme.of(context).textTheme.displaySmall,
                         textAlign: TextAlign.center,),
              ),
              // onTap: (){
              //   switch(index){
              //     case 1:remarkbox(context,task);
              //   }
              // }
            );
          }),
          DataCell(
            Center(
              child:Container(
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
                                    
                                  },
                                  child: Text(
                                    'REQUEST',
                                    style:
                                        Theme.of(context).textTheme.displayMedium,
                                  ),
                                ),
                              ),
                            ),
            ),
          ),
        ]);
    
    }).toList();
  } 
        
        
      
}
