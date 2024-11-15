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
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    _scafoldkey.currentContext!, Approutes().homescreen);
              },
            ),
            title: Text(
              "Change Password",
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            )),
        body: Center(
          child: ListView(children: [
            Card(
                margin: const EdgeInsets.all(10),
                elevation: 3,
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
                                // Text(
                                //   'Search For Stop Details',
                                //   style: Theme.of(context).textTheme.titleLarge,
                                // ),
                                const SizedBox(height: 10),

                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: TextFormField(
                                    controller: _crntpswrdcontroller,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                    decoration: InputDecoration(
                                      labelText: 'Current Password',
                                      labelStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                      hintText: 'Enter current password',
                                      hintStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Enter Current Password';
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
                                          context
                                              .read<ElevatedBtnProvider>()
                                              .changeSelectedVal(true);
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
            Consumer<ElevatedBtnProvider>(
              builder: (context, provider, child) {
                if (provider.selectedVal == false) {
                  return Container();
                } else if (provider.selectedVal == true) {
                  return const OtpFiled();
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
    );
  }
// Widget buildotp() {}
}
