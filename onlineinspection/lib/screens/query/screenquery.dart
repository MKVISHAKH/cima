import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/model/query/questions/question_req/additional_field.dart';
import 'package:onlineinspection/model/query/questions/questionresp/additional_info.dart';
import 'package:onlineinspection/provider/additional_info/additional_info_provider.dart';
import 'package:onlineinspection/widgets/Textformfield/textfromfield.dart';

class ScreenQuery extends StatefulWidget {
  const ScreenQuery(
      {super.key,
      required this.bankname,
      required this.branch,
      required this.regNo,
      required this.lastinspdt,
      required this.name,
      required this.role,
      required this.activity});
  final String? bankname;
  final String? branch;
  final String? regNo;
  final String? lastinspdt;
  final String? name;
  final String? role;
  final String? activity;
  @override
  State<ScreenQuery> createState() => _ScreenQueryState();
}

class _ScreenQueryState extends State<ScreenQuery> {
  String locationMessage = 'Current Location of the User';
  String lat = '';
  String long = '';
  Timer? locationTimer;
  List<Datum>? questval;
  bool? skip;
  String outputDate = '';
  Getbasicinfo? sharedVal;
  Sharedpref? userval;
  double doublelat = 0;
  double doublelong = 0;
  final _namecontroller = TextEditingController();
  final _nocontroller = TextEditingController();
  List<AdditionalInfo>? addinfo;
  int? infoLgth;
  bool? isVisible;
  String? mname;
  String? mnum;
  //final _amntcontroller = TextEditingController();
  List<AdditionalField> fieldList = [];

final GlobalKey<FormState> formkey = GlobalKey<FormState>();
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
            log('query screen strtque init:$locationMessage');
          });
          getStartquestion(doublelat, doublelong);
        },
      );
      isVisible = false;
      getSharedvalue();
      final lstinspdt = widget.lastinspdt;
      if (lstinspdt == '') {
        outputDate = '';
      } else if (lstinspdt == null) {
        outputDate = '';
      } else {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(lstinspdt);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat('dd-MM-yyyy');
        outputDate = outputFormat.format(inputDate);
        print(outputDate);
        //outputDate=lstinspdt;
      }
    });
  }

  @override
  void dispose() {
    selectedFormatNotifier.value = '';
    Livelocationfun.instance.stopTracking();
    super.dispose();
  }

  getSharedvalue() async {
    sharedVal = await SharedPrefManager.instance.getSocietyinfo();
    userval = await SharedPrefManager.instance.getSharedData();
  }

  Future getStartquestion(double doublelat, double doublelong) async {
    if (doublelat != 0 && doublelong != 0) {
      try {
        final queReq = Getbasicinfo.val(
            schedulerId: sharedVal!.schedulerId,
            schedulerDate: sharedVal!.schedulerDate,
            userId: userval!.userId,
            socId: sharedVal!.socId,
            branchId: sharedVal!.branchId,
            lattitude: doublelat,
            longitude: doublelong,
            activity: widget.activity);
        questval = await QuestionsFunctions.instance.fetchQueStrt(queReq);
        if (questval == null) {
          Fluttertoast.showToast(
              msg: "No Data Found",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 15.0);
        } else {
          selectedFormatNotifier.value = '';
          if (mounted) {
            setState(() {});
          }
        }
      } catch (e) {
        print("Failed to parse coordinates: $e");
      }
    } else {
      Fluttertoast.showToast(
          msg: "Location are not ready yet.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);
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
          getStartquestion(doublelat, doublelong);
        },
      );
      print("Location coordinates are not ready yet.");
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
                await warningBox(context);
              }
              //log('BackButton pressed!');
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
                        warningBox(context);
                      },
                    ),
                    title: Text(
                      "Questionnaire",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary),
                    )),
                body: ListView(
                  children: [
                    Container(
                      // margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: Color(0xff1569C7),
                      ),
                      child: ListTile(
                        title: Text(
                          widget.bankname ?? 'User',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Branch: ${widget.branch ?? 'Branch'}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              'Reg.No: ${widget.regNo ?? 'RegNo'}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              'Last Inspection Date: $outputDate',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (questval != null && questval!.isNotEmpty) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Q.${questval!.first.sortOrder}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextButton(
                                    onPressed: () {
                                      getNextQue(context, skipnxt);
                                    },
                                    child: Text(
                                      'Skip',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 16,
                                        fontFamily: 'Poppins-Medium',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ))
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(
                              questval!.first.question ?? '',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: questval!.first.option?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final option =
                                      questval!.first.option?[index].option ??
                                          'activity';
                                  addinfo =
                                      questval!.first.option?[index].addInfo ??
                                          [];
                                  infoLgth = addinfo?.length ?? 0;

                                  //infoLgth!=0?isVisible==true:isVisible==false;
                                  isVisible = infoLgth != 0;

                                  return FormatRadioButton(
                                    title: option,
                                    type: option,
                                    txtstyl: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                    color: const Color.fromARGB(255, 2, 73, 4),
                                    additionalInfo: addinfo ?? [],
                                  );
                                },
                              ),
                            ),
                            Consumer<AdditionalInfoProvider>(
                              builder: (context, provider, _) {
                                if (provider.selectedInfo.isEmpty) {
                                  return Container(); // No fields to display
                                }

                                return Card(
                                  margin: const EdgeInsets.all(10),
                                  elevation: 3,
                                  color: Colors.white,
                                  child: Form(
                                    key: formkey,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: provider.selectedInfo.length,
                                      itemBuilder: (context, index) {
                                        final infoField =
                                            provider.selectedInfo[index];
                                        // final controller = TextEditingController();
                                        final controller =
                                            infoField.name == 'mname'
                                                ? _namecontroller
                                                : _nocontroller;
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextInputfield(
                                            label: infoField.label ??
                                                'Label $index',
                                            hint:
                                                'Enter ${infoField.label ?? 'info'}',
                                            inputType: TextInputType.name,
                                            inputAction: TextInputAction.next,
                                            cmncontroller: controller,
                                            //formkey: GlobalKey<FormState>(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
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
                                  onPressed: () {
                                    // if (formkey.currentState?.validate() ?? false) {
                                    //     formkey.currentState!.save();
                                    //     mname = _namecontroller.text;
                                    //     mnum = _nocontroller.text;

                                    //     // Proceed to next question
                                    //     getNextQue(context, proceednxt);
                                    //   }
                                    getNextQue(context, proceednxt);
                                  },
                                  child: Text(
                                    'NEXT',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            const Center(
                                child: Padding(
                              padding: EdgeInsets.only(top: 150.0),
                              child: CircularProgressIndicator(),
                            )),
                          ],
                        ],
                      ),
                    ),
                    // buildQuestion(),
                  ],
                )),
          )
        ],
      ),
    );
  }

  getNextQue(BuildContext context, String type) {
    Livelocationfun.instance.startTracking(
      context: context,
      onLocationUpdate: (position) {
        setState(() {
          doublelat = position.latitude;
          doublelong = position.longitude;
          locationMessage =
              'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
          log('query screen updateque:$locationMessage');
        });
        //getStartquestion(doublelat,doublelong);
      },
    );
    String selectedValue = selectedFormatNotifier.value;
    if (doublelat != 0 && doublelong != 0) {
      
      fieldList.add(AdditionalField(mname: mname, memno: mnum, amount: mnum));
      if (type == skipnxt) {
        skip = true;

        final queReq = QuestionReq(
            questionId: questval?.single.questionId,
            inspectionId: questval?.single.inspId,
            userId: userval!.userId,
            socId: sharedVal!.socId,
            branchId: sharedVal!.branchId,
            // answer: selectedValue,
            addField: fieldList,
            lattitude: doublelat,
            longitude: doublelong,
            skip: skip);
        skipBox(context, queReq);
      } else if (type == proceednxt) {
        try {
          if (selectedValue.isNotEmpty) {
            skip = false;
            final queReq = QuestionReq(
                questionId: questval?.single.questionId,
                inspectionId: questval?.single.inspId,
                userId: userval!.userId,
                socId: sharedVal!.socId,
                branchId: sharedVal!.branchId,
                answer: selectedValue,
                queStatus: questval?.single.questatus,
                lattitude: doublelat,
                longitude: doublelong,
                skip: skip);

            confrmBox(context, queReq);
          } else {
            print("Selected option: $selectedValue");
            Fluttertoast.showToast(
                msg: "Please select one Option",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white,
                textColor: const Color.fromRGBO(0, 0, 0, 1),
                fontSize: 15.0);
          }
        } catch (e) {
          print("Failed to parse coordinates: $e");
        }
      } else if (type == cmpltdNxt) {
        Provider.of<AdditionalInfoProvider>(context, listen: false)
            .clearSelectedInfo();
        SocietyListFunctions.instance.getSocietyList(doublelat, doublelong);
        selectedFormatNotifier.value = '';
        selectedItems.value = {0};

        Navigator.pushAndRemoveUntil(
          context,
          Approutes().assignedscreen,
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      }
    } else {
      Fluttertoast.showToast(
          msg: "Location are not ready yet.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 15.0);

      print("Location coordinates are not ready yet.");
    }
  }

  Future warningBox(BuildContext context) async => showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            title: Center(
                child: Text("Are you sure Do You want to exit?",
                    style: Theme.of(context).textTheme.displaySmall)),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('NO',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  Provider.of<AdditionalInfoProvider>(context, listen: false)
                      .clearSelectedInfo();
                  selectedFormatNotifier.value = '';
                  selectedItems.value = {0};
                  Navigator.pushAndRemoveUntil(
                    context,
                    Approutes().assignedscreen,
                    (Route<dynamic> route) =>
                        false, // Remove all previous routes
                  );
                },
                child: Text('YES',
                    style: Theme.of(context).textTheme.displayMedium),
              ),
            ],
          ));

  Future confrmBox(BuildContext context, QuestionReq val) async =>
      showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                title: Center(
                    child: Text("Do you want to proceed?",
                        style: Theme.of(context).textTheme.displaySmall)),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('NO',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () async {
                      Provider.of<AdditionalInfoProvider>(context,
                              listen: false)
                          .clearSelectedInfo();

                      questval =
                          await QuestionsFunctions.instance.fetchQueUpdt(val);
                      _namecontroller.clear();
                      _nocontroller.clear();
                      if (questval == null || questval == []) {
                        Fluttertoast.showToast(
                            msg: "No Data Found",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: const Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 15.0);
                      } else if (questval!.isNotEmpty &&
                          questval!.length == 1) {
                        if (questval?.single.questatus == 'COMPLETED') {
                          selectedFormatNotifier.value = '';

                          final status = questval!.single.questatus;
                          log('$status');
                          if (!context.mounted) return;

                          queSubmit(context);
                        } else if (questval?.single.questatus ==
                            'PARTIALLY_COMPLETED') {
                          final status = questval!.single.questatus;
                          log('$status');
                          if (!context.mounted) return;
                          partialComp(context);
                        } else {
                          log('$questval');
                          final status = questval!.single.questatus;
                          log('$status');
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                          selectedFormatNotifier.value = '';
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "something went wrong retry",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: const Color.fromRGBO(0, 0, 0, 1),
                            fontSize: 15.0);
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('YES',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                ],
              ));

  Future skipBox(BuildContext context, QuestionReq val) async =>
      showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.primaryFixed,
                title: const Center(
                    child: Text("Do you want to Skip?",
                        style: TextStyle(
                            color: Color.fromARGB(255, 240, 20, 5),
                            fontSize: 16,
                            fontFamily: 'Poppins-Medium'))),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('NO',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () async {
                      Provider.of<AdditionalInfoProvider>(context,
                              listen: false)
                          .clearSelectedInfo();

                      try {
                        questval =
                            await QuestionsFunctions.instance.fetchQueUpdt(val);
                        if (questval == null || questval == []) {
                          Fluttertoast.showToast(
                              msg: "No Data Found",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.white,
                              textColor: const Color.fromRGBO(0, 0, 0, 1),
                              fontSize: 15.0);
                        } else if (questval?.single.questatus == 'COMPLETED') {
                          if (!context.mounted) return;
                          selectedFormatNotifier.value = '';
                          queSubmit(context);
                        } else if (questval?.single.questatus ==
                            'PARTIALLY_COMPLETED') {
                          if (!context.mounted) return;
                          selectedFormatNotifier.value = '';
                          partialComp(context);
                        } else {
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                          selectedFormatNotifier.value = '';
                          if (mounted) {
                            setState(() {});
                          }
                        }
                      } catch (e) {
                        log('$questval');
                      }
                    },
                    child: Text('YES',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                ],
              ));

  queSubmit(BuildContext context) async => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            title: Center(
                child: Text("Inspection completed Successfully",
                    style: Theme.of(context).textTheme.displaySmall)),
            actions: [
              Container(
                height: 45,
                width: 130,
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
                      getNextQue(context, cmpltdNxt);
                    },
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ],
          )));

  partialComp(BuildContext context) async => showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
          canPop: false,
          child: AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primaryFixed,
            title: Center(
                child: Text(
                    "Inspection not completed,Please answer all questions",
                    style: Theme.of(context).textTheme.displaySmall)),
            actions: [
              Container(
                height: 45,
                width: 130,
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
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'OK',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ],
          )));
}
