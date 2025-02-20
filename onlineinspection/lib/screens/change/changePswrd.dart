import 'dart:developer';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenChangePswrd extends StatefulWidget {
  const ScreenChangePswrd({super.key});

  @override
  State<ScreenChangePswrd> createState() => _ScreenChangePswrdState();
}

class _ScreenChangePswrdState extends State<ScreenChangePswrd> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _crntpswrdcontroller = TextEditingController();
  final _newpswrdcontroller = TextEditingController();
  final _cnfrmpswrdcontroller = TextEditingController();
  bool passtoggle = true;
  String? selectedBusType;
  List<String> busTypeList = [];
  //final _scaffoldKey = GlobalKey<ScaffoldState>();

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
                  Navigator.pushReplacement(context, Approutes().homescreen);
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
                                    'Change Password',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      controller: _crntpswrdcontroller,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                      decoration: InputDecoration(
                                        labelText: 'Old Password',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        hintText: 'Enter old password',
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter old Password';
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        decoration: InputDecoration(
                                          labelText: 'New Password',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
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
                                          } else if (value ==
                                              _crntpswrdcontroller.text) {
                                            return 'New Password should not be same as old password';
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
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
                                                  .primary,
                                            ])),
                                    child: Theme(
                                      data: MyTheme.buttonStyleTheme,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            // context
                                            //     .read<ElevatedBtnProvider>()
                                            //     .changeSelectedVal(true);
                                            final sharedValue =
                                                await SharedPrefManager.instance
                                                    .getSharedData();
                                            final usrId = sharedValue!.userId;
                                            final penNo = sharedValue.pen;
                                            final oldpswrd =
                                                _crntpswrdcontroller.text;
                                            final newpswrd =
                                                _newpswrdcontroller.text;
                                            final cnfrmpaswrd =
                                                _cnfrmpswrdcontroller.text;
                                            final chngreq = ChangeReq(
                                                pen: penNo.toString(),
                                                userId: usrId.toString(),
                                                password: oldpswrd,
                                                newPassword: newpswrd,
                                                retypePassword: cnfrmpaswrd);
                                            if (!context.mounted) return;

                                            changePswrd(chngreq, context);
                                          }
                                        },
                                        child: Text('RESET',
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
              Consumer<LoadingProvider>(
                  builder: (context, loadingProvider, child) {
                return loadingProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 2, 128, 6),
                          ),
                        ),
                      )
                    : const SizedBox.shrink();
              }),
            ]),
          ),
        ),
      ),
    );
  }

  Future changePswrd(ChangeReq val, BuildContext context) async {
    try {
      String? message;
      final loadingProvider = context.read<LoadingProvider>();
      loadingProvider.toggleLoading();
      final chngresp = await Ciadata().changePswd(val);
      final resultAsjson = jsonDecode(chngresp.toString());
      final changeval =
          ChangeResp.fromJson(resultAsjson as Map<String, dynamic>);
      loadingProvider.toggleLoading();
      if (chngresp == null) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (chngresp.statusCode == 200 && changeval.status == 'success') {
        //final msg=changeval.message;
        Fluttertoast.showToast(
            msg: "Password Changed Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 15.0);
        Navigator.push(_scafoldkey.currentContext!, Approutes().homescreen);
      } else if (changeval.status == 'failure') {
        if (!context.mounted) return;

        CommonFun.instance.showApierror(context, "Password can't changed");
      } else if (message == 'Unauthenticated' || chngresp.statusCode == 401) {
        if (!context.mounted) return;

        CommonFun.instance.signout(context);
      } else if (chngresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not reached");

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
