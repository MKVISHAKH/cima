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
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                    _scafoldkey.currentContext!, Approutes().loginscreen);
              },
            ),
            title: Text(
              "Forgot Username",
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
                                    controller: _mobilenocontroller,
                                    keyboardType: TextInputType.phone,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
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
                                                .labelLarge,
                                          ),
                                        ),
                                        labelText: 'Registered Mobile No',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge),
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
