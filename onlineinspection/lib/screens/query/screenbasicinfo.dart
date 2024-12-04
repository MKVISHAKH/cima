import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenBasicInfo extends StatefulWidget {
  const ScreenBasicInfo({super.key});

  @override
  State<ScreenBasicInfo> createState() => _ScreenBasicInfoState();
}

class _ScreenBasicInfoState extends State<ScreenBasicInfo> {
  String? usrName;
  String? time;
  String? date;
  String? bankname;
  String? branch;
  String outputDate = '';
  @override
  void initState() {
    super.initState();
    getShareddata();
  }

  Future<bool?> popscreen(BuildContext context) async {
    selectedItems.value = {0};
    Navigator.push(context, Approutes().assignedscreen);
    return true;
  }

  Future<void> getShareddata() async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    usrName = sharedValue?.name?.toUpperCase() ?? 'User';
  }

  List<int> getSelectedActivityIds() {
    return selectedItems.value.toList();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          if (didPop) return;
          await popscreen(context);
        }
        //log('BackButton pressed!');
      },
      child: Scaffold(
          backgroundColor: const Color(0xff98c1d9),
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                onPressed: () {
                  selectedItems.value = {0};
                  Navigator.pushReplacement(
                      context, Approutes().assignedscreen);
                },
              ),
              title: Text(
                "Questionnaire",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              )),
          body: ListView(
            children: [
              ValueListenableBuilder(
                  valueListenable:
                      SocietyListFunctions.instance.getSocietyDetNotifier,
                  builder: (BuildContext context, List<SocietyDet> newList,
                      Widget? _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: newList.length,
                      itemBuilder: (context, index) {
                        final society = newList[index];
                        final lstinspdt = society.lastInspectionDate;
                        if (lstinspdt == null) {
                          outputDate = '';
                          var now = DateTime.now();
                          DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                          date = dateFormat.format(now);
                          print(date);
                        } else {
                          var now = DateTime.now();
                          DateFormat dateFormat = DateFormat("dd-MM-yyyy");
                          date = dateFormat.format(now);
                          print(date);

                          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(lstinspdt);
                          var inputDate = DateTime.parse(parseDate.toString());
                          var outputFormat = DateFormat('dd-MM-yyyy');
                          outputDate = outputFormat.format(inputDate);
                          print(outputDate);

                        }

                        return Column(
                          children: [
                            Container(
                              // margin: const EdgeInsets.all(5.0),
                              padding: const EdgeInsets.only(left: 5.0, top: 5),
                              decoration: const BoxDecoration(
                                color: Color(0xff1569C7),
                                // gradient: LinearGradient(
                                //   begin: Alignment.topLeft,
                                //   end: Alignment.bottomRight,
                                //   colors: [
                                //     Theme.of(context).colorScheme.primary,
                                //     Theme.of(context).colorScheme.primary
                                //   ],
                                // ),
                                // borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: ListTile(
                                title: Text(
                                  society.socName ?? 'User',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      'Branch: ${society.branchName ?? 'Branch'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      'Reg.No: ${society.regNo ?? 'RegNo'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      'Circle/District: ${society.circleName ?? 'circle'}/${society.districtName ?? 'dist'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    Text(
                                      'Class(Rule 182): ${society.socClass ?? 'class'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Name: ${society.user?.name ?? ''}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      'Role: ${society.user?.roleName ?? ''}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      'Inspection Date: $date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      'Last Inspection Date: $outputDate',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                  ],
                                ),
                                // trailing: Column(
                                //   children: [

                                //   ],),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            buildQuestn(society),
                            Container(
                              height: 45,
                              width: 150,
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
                                    List<int> selectedIds =
                                        getSelectedActivityIds();
                                    if (selectedIds.isNotEmpty) {
                                      String selectedIdsString =
                                          "[${selectedIds.join(", ")}]";
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) => ScreenQuery(
                                            bankname: society.socName,
                                            branch: society.branchName,
                                            regNo: society.regNo,
                                            lastinspdt: outputDate,
                                            name: society.user?.name ?? '',
                                            role: society.user?.roleName ?? '',
                                            activity: selectedIdsString,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Please select one option",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          fontSize: 15.0);
                                    }
                                  },
                                  child: Text(
                                    'NEXT',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ],
          )),
    );
  }

  Widget buildQuestn(SocietyDet society) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Basic Information",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(height: 10),

        //  buildInfoRow("Reg. No:",society.regNo ),
        //  buildInfoRow("Circle:",society.circleName ),
        //  buildInfoRow("District:",society.districtName ),

        Text(
          'സംഘം നടത്തുന്ന പ്രവർത്തനങ്ങൾ',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: society.societyActivity?.length ?? 0,
          itemBuilder: (context, index) {
            final activity = society.societyActivity![index];
            // final inspstat=society.inspStatus;
            return FormatCheckbox(
              title: activity.activityName ?? 'activity',
              type: activity.activityId ?? 0,
              txtstyl: Theme.of(context).textTheme.displaySmall,
              color: Colors.blue,
              selectedItems: selectedItems,
            );
          },
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            value ?? "N/A",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
