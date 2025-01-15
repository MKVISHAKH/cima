import 'dart:developer';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenForgotUser extends StatefulWidget {
  const ScreenForgotUser({super.key});

  @override
  State<ScreenForgotUser> createState() => _ScreenForgotUserState();
}

class _ScreenForgotUserState extends State<ScreenForgotUser> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _mobilenocontroller = TextEditingController();
  String? selectedBusType;
  List<String> busTypeList = [];
  String? mobNo;
  int? refid;

  @override
  void initState() {
    super.initState();
    // fetchBusList();
    Future.delayed(Duration.zero, () {
      context.read<ElevatedBtnProvider>().changeSelectedVal(false);
    });
    //context.read<ElevatedBtnProvider>().changeSelectedVal(false);
  }

  Future<bool?> popscreen(BuildContext context) async {
    Navigator.push(context, Approutes().loginscreen);
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
          key: _scafoldkey,
          backgroundColor: Theme.of(context).colorScheme.primaryFixed,
          appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(
                      _scafoldkey.currentContext!, Approutes().loginscreen);
                },
              ),
              title: Text(
                "",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              )),
          body: Center(
            child: ListView(children: [
              Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 3,
                  color: const Color(0xff1569C7),
                  child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.onSecondary),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Theme(
                            data: MyTheme.googleFormTheme,
                            child: Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  Text(
                                    'Forgot Username',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 30),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      controller: _mobilenocontroller,
                                      keyboardType: TextInputType.phone,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      // style:kBodyText,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      // onSaved: (newValue) => mobile = newValue,

                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter mobile Number";
                                        } else if (_mobilenocontroller
                                                    .text.length <
                                                10 ||
                                            _mobilenocontroller.text.length >
                                                10) {
                                          return "Enter valid Mobile number";
                                        } else if (value.contains(' ')) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Remove Space from  Mobile number",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              fontSize: 15.0);
                                        }

                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 25),
                                          //fillColor: Colors.white,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14, horizontal: 15),
                                            child: Text(
                                              " (+91)",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ),
                                          labelText: 'Registered Mobile No',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
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
                                            context
                                                .read<ElevatedBtnProvider>()
                                                .changeSelectedVal(true);
                                            setState(() {
                                              mobNo = _mobilenocontroller.text;
                                            });
                                            userVerify(mobNo, context);
                                          }
                                        },
                                        child: Text('SHOW',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ))),
              Consumer<ElevatedBtnProvider>(
                builder: (context, provider, child) {
                  if (provider.selectedVal == false) {
                    return Container();
                  } else if (provider.selectedVal == true) {
                    return OtpFiled(
                      type: frgtUsr,
                      refId: refid,
                      mob: mobNo,
                    );
                  }
                  return Container();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Future userVerify(String? mobNo, BuildContext context) async {
    try {
      final loadingProvider = context.read<LoadingProvider>();
      loadingProvider.toggleLoading();

      final val = ChangeReq(mobNo: mobNo);

      final chngresp = await Ciadata().frgtusrName(val);
      final resultAsjson = jsonDecode(chngresp.toString());
      final changeval =
          ChangeResp.fromJson(resultAsjson as Map<String, dynamic>);

      loadingProvider.toggleLoading();
      if (chngresp == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (chngresp.statusCode == 200 && changeval.status == 'success') {
        refid = changeval.data?.refId ?? 0;
        Fluttertoast.showToast(
            msg: "Otp sended on your registered mobile No",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 15.0);

        _scafoldkey.currentContext!
            .read<ElevatedBtnProvider>()
            .changeSelectedVal(true);
      } else if (changeval.status == 'failure') {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "No User Found");
      } else if (chngresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (chngresp.statusCode == 408) {
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
