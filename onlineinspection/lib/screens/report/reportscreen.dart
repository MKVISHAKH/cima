import 'dart:developer';
import 'package:onlineinspection/core/hook/hook.dart';

class ScreenReport extends StatefulWidget {
  const ScreenReport({super.key});

  @override
  State<ScreenReport> createState() => _ScreenReportState();
}

class _ScreenReportState extends State<ScreenReport> {
  final _formkey = GlobalKey<FormState>();
  final _scafoldkey = GlobalKey<ScaffoldState>();
  final _datecontroller = TextEditingController();
  // final _newmobnocontroller = TextEditingController();
  //final _cnfrmpswrdcontroller = TextEditingController();
  bool passtoggle = true;
  String? selectedBusType;
  List<String>? triplist = [];
  String? dropdownbusvalue;
  List<Map<String, Object>> tripnamelst = [];
  @override
  void initState() {
    super.initState();
    // fetchBusList();
    Future.delayed(Duration.zero, () {
      context.read<ElevatedBtnProvider>().changeSelectedVal(false);
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // triplist = await StopFunctions.instance.tripNameList();
      setState(() {
        // tripnamelst = triplist!.map((trip) {
        //   String routeDisplay = trip.tripName ?? "";

        //   return {
        //     'tripId': trip.tripId!, // routeId as int
        //     'display': routeDisplay // Display label
        //   };
        // }).toList(); //calling registarion list  from main model
      });
    });
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
              "Inspection Report",
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
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 5, right: 5),
                                    child: DropdownButtonFormField(
                                      //controller: _selectsearchtypedropdwn,
                                      dropdownColor: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      icon: Icon(Icons.arrow_drop_down,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Society',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      items: tripnamelst.map((tripMap) {
                                        String combinedValue =
                                            '${tripMap['tripId']}+${tripMap['display']}';
                                        return DropdownMenuItem<String>(
                                          value: combinedValue,
                                          child: Text(
                                            tripMap['display']
                                                as String, // Display the route name and via
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newvalue) {
                                        log('Bus :$newvalue');
                                        // List<String> parts =
                                        //     newvalue!.split('+');
                                        // tripId = parts[0];
                                        // display = parts[1];
                                        //  print(tripId);
                                        //  print(display);
                                        //final value=tripMap['display'] as String;

                                        context
                                            .read<ElevatedBtnProvider>()
                                            .changeSelectedVal(false);

                                        setState(() {
                                          dropdownbusvalue = newvalue;
                                          //context.read<ElevatedBtnProvider>().changeSelectedVal(true);
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Select A Society';
                                        } else {
                                          return null;
                                        }
                                      },
                                      value: dropdownbusvalue,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 5, right: 5),
                                    child: TextFormField(
                                      controller: _datecontroller,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        labelStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                        suffixIcon: Icon(Icons.calendar_today,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary),
                                      ),
                                      onTap: () =>
                                          _selectDate(context, _datecontroller),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Select Date';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
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
                                      child: Text('SEARCH',
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
            //     Consumer<ElevatedBtnProvider>(
            //   builder: (context, provider, child) {
            //     if (provider.selectedVal == false) {
            //       return Container();
            //     } else if (provider.selectedVal == true) {
            //       return const OtpFiled();
            //     }
            //     return Container();
            //   },
            // ),
          ]),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)),
      lastDate: DateTime.now(),
    );
    if (picked == null) {
      return;
    } else {
      setState(() {
        controller.text =
            "${picked.toLocal().day}-${picked.toLocal().month}-${picked.toLocal().year}";
        log(controller.text);
      });
    }
  }
}
