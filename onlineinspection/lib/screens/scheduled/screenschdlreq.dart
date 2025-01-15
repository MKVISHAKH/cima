import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenSchdlReq extends StatefulWidget {
  const ScreenSchdlReq(
      {super.key,
      this.bankName,
      this.branch,
      this.inspDt,
      this.schdlId,
      this.socId,
      this.brId,
      this.reqStatus});

  final String? bankName;
  final String? branch;
  final String? inspDt;
  final int? schdlId;
  final int? socId;
  final int? brId;
  final String? reqStatus;

  @override
  State<ScreenSchdlReq> createState() => _ScreenSchdlReqState();
}

class _ScreenSchdlReqState extends State<ScreenSchdlReq> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();

  final _remarkscontroller = TextEditingController();
  Future<bool?> popscreen(BuildContext context) async {
    selectedItems.value = {0};
    Navigator.push(context, Approutes().schdleTabScreen);
    return true;
  }

  bool isVisible = true;
  String? title;
  String? remarks;
  bool isStatusVisible = true;
  bool isReqDtVisible = true;
  bool isRejByVisible = true;
  bool isRejDtVisible = true;
  bool isAprByVisible = true;
  bool isAprDtVisible = true;

  String? reqdt;
  Data? reStatus;
  String? rejdt;
  String? aprdt;
  String? rejby;
  String? aprby;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final soclist = await SocietyListFunctions.instance.getSocietyUser();
      reStatus = await SchedulelistFun.instance
          .resheduleStatus(widget.schdlId, context);

      setState(() {
        title = reStatus?.title;
        remarks = reStatus?.remarks;
        final reqDt = reStatus?.requestedDate;
        if (reqDt == null) {
          reqdt = '';
        } else {
          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(reqDt);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          reqdt = outputFormat.format(inputDate);
          print(reqdt);
        }
        final rejDt = reStatus?.rejectedDate;
        if (rejDt == null) {
          rejdt = '';
        } else {
          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(rejDt);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          rejdt = outputFormat.format(inputDate);
          print(rejdt);
        }
        final aprDt = reStatus?.approvedDate;
        if (aprDt == null) {
          aprdt = '';
        } else {
          DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(aprDt);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('dd-MM-yyyy');
          aprdt = outputFormat.format(inputDate);
          print(aprdt);
        }

        rejby = reStatus?.rejectedBy;
        aprby = reStatus?.approvedBy;

        if (widget.reqStatus == 'Scheduled') {
          isVisible = isVisible;
          isStatusVisible = !isStatusVisible;
        } else if (widget.reqStatus == 'Requested') {
          isVisible = !isVisible;
          isStatusVisible = isStatusVisible;
          isReqDtVisible = isReqDtVisible;
          isRejByVisible = !isRejByVisible;
          isRejDtVisible = !isRejDtVisible;
          isAprByVisible = !isAprByVisible;
          isAprDtVisible = !isAprDtVisible;
        } else if (widget.reqStatus == 'Req Rejected') {
          isVisible = isVisible;
          isStatusVisible = isStatusVisible;
          isReqDtVisible = isReqDtVisible;
          isRejByVisible = isRejByVisible;
          isRejDtVisible = isRejDtVisible;
          isAprByVisible = !isAprByVisible;
          isAprDtVisible = !isAprDtVisible;
        } else if (widget.reqStatus == 'Req Approved') {
          isVisible = !isVisible;
          isStatusVisible = isStatusVisible;
          isReqDtVisible = isReqDtVisible;
          isAprByVisible = isAprByVisible;
          isAprDtVisible = isAprDtVisible;
          isRejByVisible = !isRejByVisible;
          isRejDtVisible = !isRejDtVisible;
        } else {
          isVisible = !isVisible;
          isStatusVisible = isStatusVisible;
          isReqDtVisible = !isReqDtVisible;
          isRejByVisible = !isRejByVisible;
          isRejDtVisible = !isRejDtVisible;
          isAprByVisible = !isAprByVisible;
          isAprDtVisible = !isAprDtVisible;
        }
      });
    });
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
          //log('BackButton pressed!');
        },
        child: Scaffold(
          key: _scafoldkey,
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
                      context, Approutes().schdleTabScreen);
                },
              ),
              title: Text(
                "Re-Schedule Request",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              )),
          body: Center(
            child: ListView(children: [
              Column(
                children: [
                  if (reStatus != null) ...[
                    Visibility(
                      visible: isStatusVisible,
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 3,
                        color: const Color(0xff1569C7),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Theme(
                                  data: MyTheme.googleFormTheme,
                                  child: Column(
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(height: 30),
                                      Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(3),
                                          1: FlexColumnWidth(0.4),
                                          2: FlexColumnWidth(4),
                                        },
                                        border: null,
                                        children: [
                                          //getname(),

                                          buildRow([
                                            'Bank Name',
                                            ':',
                                            widget.bankName ?? ''
                                          ]),
                                          buildRow([
                                            'Branch',
                                            ':',
                                            widget.branch ?? ''
                                          ]),
                                          buildRow([
                                            'Inspection Date',
                                            ':',
                                            widget.inspDt ?? ''
                                          ]),
                                          buildRow(
                                              ['Remarks', ':', remarks ?? '']),

                                          isReqDtVisible
                                              ? buildRow([
                                                  'Requested Date',
                                                  ':',
                                                  reqdt ?? ''
                                                ])
                                              : buildRow(['', '', '']),
                                          isRejByVisible
                                              ? buildRow([
                                                  'Rejected By',
                                                  ':',
                                                  rejby ?? ''
                                                ])
                                              : buildRow(['', '', '']),
                                          isRejDtVisible
                                              ? buildRow([
                                                  'Rejected Date',
                                                  ':',
                                                  rejdt ?? ''
                                                ])
                                              : buildRow(['', '', '']),
                                          isAprByVisible
                                              ? buildRow([
                                                  'Approved By',
                                                  ':',
                                                  aprby ?? ''
                                                ])
                                              : buildRow(['', '', '']),
                                          isAprDtVisible
                                              ? buildRow([
                                                  'Approved Date',
                                                  ':',
                                                  aprdt ?? ''
                                                ])
                                              : buildRow(['', '', '']),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ])),
                                        child: Theme(
                                          data: MyTheme.buttonStyleTheme,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              Navigator.pushReplacement(context,
                                                  Approutes().schdleTabScreen);
                                            },
                                            child: Text('BACK',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Consumer<LoadingProvider>(builder:
                                          (context, loadingProvider, child) {
                                        return loadingProvider.isLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(
                                                    Color.fromARGB(
                                                        255, 2, 128, 6),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox.shrink();
                                      }),
                                    ],
                                  )),
                            )),
                      ),
                    ),
                    Visibility(
                      visible: isVisible,
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 3,
                        color: const Color(0xff1569C7),
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondary),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Theme(
                                  data: MyTheme.googleFormTheme,
                                  child: Form(
                                    key: _formkey,
                                    child: Column(
                                      //crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Reschedule Request Form',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        const SizedBox(height: 30),
                                        Table(
                                          columnWidths: const {
                                            0: FlexColumnWidth(3),
                                            1: FlexColumnWidth(0.4),
                                            2: FlexColumnWidth(4),
                                          },
                                          border: null,
                                          children: [
                                            //getname(),

                                            buildRow([
                                              'Bank Name',
                                              ':',
                                              widget.bankName ?? ''
                                            ]),
                                            buildRow([
                                              'Branch',
                                              ':',
                                              widget.branch ?? ''
                                            ]),
                                            buildRow([
                                              'Inspection Date',
                                              ':',
                                              widget.inspDt ?? ''
                                            ]),
                                          ],
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15.0,
                                                horizontal: 0.0),
                                            child: TextFormField(
                                              controller: _remarkscontroller,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 5,
                                              maxLength: 200,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineLarge,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return "Please enter Remarks";
                                                }

                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 15,
                                                          horizontal: 25),
                                                  fillColor: Colors.white,
                                                  filled: true,
                                                  hintText: 'Enter remarks',
                                                  labelStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 2, 89, 136),
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'Poppins-Medium',
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ])),
                                          child: Theme(
                                            data: MyTheme.buttonStyleTheme,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                if (_formkey.currentState!
                                                    .validate()) {
                                                  final sharedValue =
                                                      await SharedPrefManager
                                                          .instance
                                                          .getSharedData();
                                                  final usrId =
                                                      sharedValue!.userId;
                                                  final rmrk =
                                                      _remarkscontroller.text;

                                                  final rscdlReq = Getbasicinfo(
                                                      schedulerId:
                                                          widget.schdlId,
                                                      userId: usrId,
                                                      socId: widget.socId,
                                                      branchId: widget.brId,
                                                      remarks: rmrk);
                                                  if (!context.mounted) return;

                                                  remarksFun(rscdlReq, context);
                                                }
                                              },
                                              child: Text('SUBMIT',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Consumer<LoadingProvider>(builder:
                                            (context, loadingProvider, child) {
                                          return loadingProvider.isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(
                                                      Color.fromARGB(
                                                          255, 2, 128, 6),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink();
                                        }),
                                      ],
                                    ),
                                  )),
                            )),
                      ),
                    ),
                  ] else ...[
                    FutureBuilder(
                      future: Future.delayed(const Duration(
                          minutes: 1)), // Add a delay of 5 seconds
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 150.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          // After 5 seconds, show the No Data Found image
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 60,
                                ),
                                Image.asset(
                                  'assets/errror/no_data_found.png', // Path to your No Data Found image
                                  height: 150,
                                  width: 150,
                                ),
                                Text('Something Went Wrong',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                // Text('Retry',
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .bodyLarge),
                                // IconButton(
                                //     onPressed: () {

                                //     },
                                //     icon: Icon(
                                //       Icons.restart_alt,
                                //       size: 45,
                                //       color: Theme.of(context)
                                //           .colorScheme
                                //           .primary,
                                //     ))
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ]
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells) => TableRow(
        children: cells.map((cell) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Text(cell, style: Theme.of(context).textTheme.labelMedium),
          );
        }).toList(),
      );

  Future remarksFun(Getbasicinfo val, BuildContext context) async {
    try {
      final loadingProvider = context.read<LoadingProvider>();
      String? message;

      loadingProvider.toggleLoading();

      final loginResponse = await Ciadata().rescdle(val);

      final resultAsjson = jsonDecode(loginResponse.toString());
      final loginval =
          Commonresp.fromJson(resultAsjson as Map<String, dynamic>);

      loadingProvider.reset();
      if (loginResponse == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (loginResponse.statusCode == 200 &&
          loginval.status == 'success') {
        final msg = loginval.message;

        Fluttertoast.showToast(
            msg: msg ?? '',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 15.0);
        if (!context.mounted) return;

       SchedulelistFun.instance.getScheduleList(context);

        if (!context.mounted) return;
        Navigator.pushReplacement(
            context, Approutes().schdleTabScreen);

        //showLoginerror(_scaffoldKey.currentContext!);
      } else if (loginval.status == 'failure') {
        final msg = loginval.message;

        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, msg);
      } else if (message == 'Unauthenticated' ||
          loginResponse.statusCode == 401) {
        if (!context.mounted) return;

        CommonFun.instance.signout(context);
      } else if (loginResponse.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (loginResponse.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }
}
