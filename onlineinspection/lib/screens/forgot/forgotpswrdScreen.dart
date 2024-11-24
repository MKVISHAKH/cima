import 'dart:developer';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenForgotPswrd extends StatefulWidget {
  const ScreenForgotPswrd({super.key});

  @override
  State<ScreenForgotPswrd> createState() => _ScreenForgotPswrdState();
}

class _ScreenForgotPswrdState extends State<ScreenForgotPswrd> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _usernamecontroller = TextEditingController();
  final _newpswrdcontroller = TextEditingController();
  final _cnfrmpswrdcontroller = TextEditingController();
  bool passtoggle = true;
  String? selectedBusType;
  List<String> busTypeList = [];
  String? penNo;
  String? newpswrd;
  String? cnfrmpswrd;
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
    return PopScope(
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
              color:const Color.fromARGB(255, 50, 150, 250) ,
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
                                'Forgot Password',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 30),

                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: _usernamecontroller,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                      labelText: 'User Name',
                                      labelStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      hintText: 'Enter Registered User Name',
                                      hintStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter User Name';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                      controller: _newpswrdcontroller,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        labelText: 'New Password',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        prefixIcon: Theme(
                                          data: MyTheme.appIconTheme,
                                          child: const Icon(
                                            Icons.lock,
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              passtoggle = !passtoggle;
                                            });
                                          },
                                          child: Theme(
                                            data: MyTheme.appIconTheme,
                                            child: Icon(
                                              passtoggle
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                          ),
                                        ),
                                      ),
                                      obscureText: passtoggle,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a password';
                                        } else if (value.length < 8) {
                                          return 'Password must be at least 8 characters';
                                        } else if (!RegExp(r'[A-Z]')
                                            .hasMatch(value)) {
                                          return 'Password must contain at least one uppercase letter';
                                        } else if (!RegExp(
                                                r'[!@#$%^&*(),.?":{}|<>]')
                                            .hasMatch(value)) {
                                          return 'Password must contain at least one special character';
                                        }
                                        return null;
                                      }),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                      controller: _cnfrmpswrdcontroller,
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                        prefixIcon: Theme(
                                          data: MyTheme.appIconTheme,
                                          child: const Icon(
                                            Icons.lock,
                                          ),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            setState(() {
                                              passtoggle = !passtoggle;
                                            });
                                          },
                                          child: Theme(
                                            data: MyTheme.appIconTheme,
                                            child: Icon(
                                              passtoggle
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                            ),
                                          ),
                                        ),
                                      ),
                                      obscureText: passtoggle,
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please confirm your password';
                                        } else if (value !=
                                            _newpswrdcontroller.text) {
                                          return 'Passwords do not match';
                                        }
                                        return null;
                                      }),
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
                                                .secondary,
                                          ])),
                                  child: Theme(
                                    data: MyTheme.buttonStyleTheme,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          setState(() {
                                            penNo = _usernamecontroller.text;
                                            newpswrd = _newpswrdcontroller.text;
                                            cnfrmpswrd =
                                                _cnfrmpswrdcontroller.text;
                                          });
                                          userVerify(penNo);
                                        }
                                      },
                                      child: Text('RESET',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                  ),
                                ),
                                Consumer<LoadingProvider>(
                                    builder: (context, loadingProvider, child) {
                                  return loadingProvider.isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color.fromARGB(255, 2, 128, 6),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }),
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
                    penNO: penNo,
                    nwpswd: newpswrd,
                    cnfrmpswrd: cnfrmpswrd,
                    refId: refid,
                  );
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
    );
  }

  Future userVerify(String? pen) async {
    final loadingProvider = context.read<LoadingProvider>();
    loadingProvider.toggleLoading();

    final val = ChangeReq(pen: pen);

    final chngresp = await Ciadata().pswrdVrfy(val);
    final resultAsjson = jsonDecode(chngresp.toString());
    final changeval = ChangeResp.fromJson(resultAsjson as Map<String, dynamic>);

    loadingProvider.toggleLoading();
    if (chngresp == null) {
      showLoginerror(_scafoldkey.currentContext!, 1);
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
      showLoginerror(_scafoldkey.currentContext!, 2);
    } else {
      showLoginerror(_scafoldkey.currentContext!, 3);
    }
  }

  Future showLoginerror(BuildContext? context, stat) async {
    //print('hi');
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: "Password can't changed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }
}
