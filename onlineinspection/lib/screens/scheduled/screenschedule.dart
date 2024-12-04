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

  Future<bool?> popscreen(BuildContext context) async {
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
          body: ListView(
            children: [ScrollableWidget(child: buildScheduledTab())],
          )),
    );
  }

  Widget buildScheduledTab() {
    return ValueListenableBuilder(
        valueListenable: SchedulelistFun.instance.getScheduleListNotifier,
        builder: (BuildContext context, List<DatumVal> newList, Widget? _) {
          return Container(
            decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).colorScheme.onSecondary),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                DataTable(
                  headingRowColor:
                      WidgetStateProperty.all(const Color(0xff1569C7)),
                  columns: getColumns(columns = [
                    'Sl.No',
                    'Sch.Date ',
                    'Society Name',
                    'Branch',
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
      ];

      return DataRow(color: WidgetStateProperty.all(rowColor), cells: [
        ...Utils.modelBuilder(cells, (index, cell) {
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
                    Navigator.push(context, Approutes().screenschdlReq);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenSchdlReq(
                          bankName: task.socName,
                          branch: task.branchName,
                          inspDt: schdldt,
                          schdlId: task.schedulerId,
                          socId: task.socId,
                          brId: task.branchId,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'REQUEST',
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
}
