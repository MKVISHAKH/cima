import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:onlineinspection/core/hook/hook.dart';
//import 'package:onlineinspection/model/query/questions/loanbond_det/loanandbonddet.dart';

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
  final _amountcontroller = TextEditingController();
  final _nocontroller = TextEditingController();
  List<AdditionalInfo>? addinfo;
  int? infoLgth;
  bool? isVisible;
  String? mname;
  String? mnum;
  String _amount = '';
  //final _amntcontroller = TextEditingController();
  List<AdditionalField> fieldList = [];
  bool isQuestionFetched = false;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // Function to add a new member
  Map<String, List<Map<String, String>>> loanbonddet={};
  List<Map<String, TextEditingController>> _memberDetails = [];
  void _addMember() {
    setState(() {
      _memberDetails.add({
        'name': TextEditingController(),
        'id': TextEditingController(),
        'email': TextEditingController(),
        'mobno': TextEditingController(),
      });
    });
  }

  // Function to remove a member
  void _removeMember(int index) {
    setState(() {
      for (var controller in _memberDetails[index].values) {
        controller.dispose();
      }
      _memberDetails.removeAt(index);
    });
  }

  // Function to get member details
  List<Map<String, String>> getMemberDetails() {
    return _memberDetails.map((member) {
      return {
        'name': member['name']!.text,
        'id': member['id']!.text,
        'email': member['email']!.text,
        'mobno': member['mobno']!.text,
      };
    }).toList();
  }

  List<Map<String, TextEditingController>> _propertyLoanDetails = [];


  List<Map<String, String>> getProperyLoandet() {
    return _propertyLoanDetails.map((loandet) {
      return {
        'loanno': loandet['loanno']!.text,
      };
    }).toList();
  }

  List<Map<String, TextEditingController>> _mssBondDetails = [];

  List<Map<String, String>> getMssNo() {
    return _mssBondDetails.map((loandet) {
      return {
        'mssno': loandet['mssno']!.text,
      };
    }).toList();
  }

  List<Map<String, TextEditingController>> _fdloanDetails = [];

  List<Map<String, String>> getFdloanNo() {
    return _fdloanDetails.map((loandet) {
      return {
        'fdloanno': loandet['fdloanno']!.text,
      };
    }).toList();
  }

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
            locationMessage ='Latitude: ${position.latitude}, Longitude: ${position.longitude}';
            log('query screen strtque init:$locationMessage');
          });

          if (!isQuestionFetched) {
            isQuestionFetched =true; // Set the flag to true after the first call
            getStartquestion(doublelat, doublelong);
          }
          // getStartquestion(doublelat, doublelong);

          // Livelocationfun.instance.stopTracking();
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
    for (var member in _memberDetails) {
      member['name']?.dispose();
      member['id']?.dispose();
      member['email']?.dispose();
      member['mobno']?.dispose();
    }
    _amountcontroller.dispose();
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

        questval =
            await QuestionsFunctions.instance.fetchQueStrt(queReq, context);
        if (questval == null || questval == []) {
          Fluttertoast.showToast(
              msg: "Something went wrong",
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
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final sessionTimer =(context.findAncestorWidgetOfExactType<MyApp>() as MyApp).sessionTimer;

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
                          widget.bankname ?? '',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Branch: ${widget.branch ?? ''}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              'Reg.No: ${widget.regNo ?? ''}',
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
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (questval != null && questval!.isNotEmpty) ...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SlNo. ${questval!.first.sno}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Q.${questval!.first.sortOrder}',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          getNextQue(context, skipnxt, [], '',{});
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
                                  final option =questval!.first.option?[index].option ??'';
                                  addinfo =questval!.first.option?[index].addInfo ??[];
                                  infoLgth = addinfo?.length ?? 0;

                                  //infoLgth!=0?isVisible==true:isVisible==false;
                                  isVisible = infoLgth != 0;

                                  return FormatRadioButton(
                                    title: option,
                                    type: option,
                                    txtstyl: Theme.of(context).textTheme.displaySmall,
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
                                  margin: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  elevation: 3,
                                  color: Colors.white,
                                  child: Form(
                                    key: formkey,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:const NeverScrollableScrollPhysics(),
                                      itemCount: provider.selectedInfo.length,
                                      itemBuilder: (context, index) {
                                        final infoField =provider.selectedInfo[index];
                                        // final controller = TextEditingController();
                                        if (infoField.name == 'mname') {
                                          return Column(
                                            //crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Add Member Details",
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                              ..._memberDetails.asMap().entries.map((entry) {
                                                int index = entry.key;
                                                Map<String,TextEditingController>
                                                    member = entry.value;
                                                return Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white, // White background
                                                    borderRadius:BorderRadius.circular(12), // Rounded corners
                                                    border: Border.all(
                                                      // Thin black border
                                                      color: Colors.black26,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 2,),
                                                  padding:const EdgeInsets.all(6),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'Member ${index + 1}',
                                                        style: Theme.of(context).textTheme.bodyLarge,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:const EdgeInsets.all(8.0),
                                                              child:TextInputfield(
                                                                label:'Member Name',
                                                                hint:'Enter member name',
                                                                inputType:TextInputType.name,
                                                                inputAction:TextInputAction.next,
                                                                cmncontroller:member['name']!,
                                                                onChanged:(value) {
                                                                  member['name']!.text =value;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:const EdgeInsets.all(8.0),
                                                              child:TextInputfield(
                                                                label:'Member ID',
                                                                hint:'Enter member ID',
                                                                inputType:TextInputType.text,
                                                                inputAction:TextInputAction.next,
                                                                cmncontroller:member['id']!,
                                                                onChanged:(value) {
                                                                  member['id']!.text =value;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:const EdgeInsets.all(8.0),
                                                              child:TextInputfield(
                                                                label:'Email Address',
                                                                hint:'Enter Email Address',
                                                                inputType:TextInputType.emailAddress,
                                                                inputAction:TextInputAction.next,
                                                                cmncontroller:member['email']!,
                                                                onChanged:(value) {
                                                                  member['email']!.text =value;
                                                                },
                                                                validator:(value) {
                                                                  if (value ==null ||value.isEmpty) {
                                                                    Fluttertoast.showToast(
                                                                        msg:"Enter Email Address",
                                                                        toastLength:Toast.LENGTH_SHORT,
                                                                        gravity:ToastGravity.CENTER,
                                                                        timeInSecForIosWeb:1,
                                                                        backgroundColor:Colors.black,
                                                                        textColor:Colors.white,
                                                                        fontSize:15.0);
                                                                    return "Enter Email Address";
                                                                  } else if (value.contains(' ')) {
                                                                    Fluttertoast.showToast(
                                                                        msg:"Remove Space from  Email Address",
                                                                        toastLength:Toast.LENGTH_SHORT,
                                                                        gravity:ToastGravity.CENTER,
                                                                        timeInSecForIosWeb:1,
                                                                        backgroundColor:Colors.black,
                                                                        textColor:Colors.white,
                                                                        fontSize:15.0);
                                                                    // showSnackBar(context,
                                                                    //     text: "Remove Space from  Mobile number");
                                                                  }
                                                                  final emailRegEx =RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
                                                                  if (!emailRegEx.hasMatch(value)) {
                                                                    Fluttertoast.showToast(
                                                                        msg:"Please enter a valid email address",
                                                                        toastLength:Toast.LENGTH_SHORT,
                                                                        gravity:ToastGravity.CENTER,
                                                                        timeInSecForIosWeb:1,
                                                                        backgroundColor:Colors.black,
                                                                        textColor:Colors.white,
                                                                        fontSize:15.0);
                                                                    return "Please enter a valid email address";
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Padding(
                                                              padding:const EdgeInsets.all(8.0),
                                                              child:TextInputfield(
                                                                label:'Mobile Number',
                                                                hint:'Enter Mobile Number',
                                                                inputType:TextInputType.number,
                                                                inputAction:TextInputAction.next,
                                                                cmncontroller:member['mobno']!,
                                                                onChanged:(value) {
                                                                  member['mobno']!.text =value;
                                                                },
                                                                inputFormatters: [
                                                                  LengthLimitingTextInputFormatter(10),
                                                                  FilteringTextInputFormatter.digitsOnly,
                                                                ],
                                                                validator:(value) {
                                                                  if (value ==null ||value.isEmpty) {
                                                                    Fluttertoast.showToast(
                                                                        msg:"Enter mobile Number",
                                                                        toastLength:Toast.LENGTH_SHORT,
                                                                        gravity:ToastGravity.CENTER,
                                                                        timeInSecForIosWeb:1,
                                                                        backgroundColor:Colors.black,
                                                                        textColor:Colors.white,
                                                                        fontSize:15.0);
                                                                    return "Enter mobile Number";
                                                                  } else if (member['mobno']!.text.length <10 ||member['mobno']!.text.length >10) {
                                                                    Fluttertoast.showToast(
                                                                        msg:"Enter valid Mobile number",
                                                                        toastLength:Toast.LENGTH_SHORT,
                                                                        gravity:ToastGravity.CENTER,
                                                                        timeInSecForIosWeb:1,
                                                                        backgroundColor:Colors.black,
                                                                        textColor:Colors.white,
                                                                        fontSize:15.0);
                                                                    return "Enter valid Mobile number";
                                                                  } else if (value.contains(' ')) {
                                                                    Fluttertoast.showToast(
                                                                        msg:"Remove Space from  Mobile number",
                                                                        toastLength:Toast.LENGTH_SHORT,
                                                                        gravity:ToastGravity.CENTER,
                                                                        timeInSecForIosWeb:1,
                                                                        backgroundColor:Colors.black,
                                                                        textColor:Colors.white,
                                                                        fontSize:15.0);
                                                                    // showSnackBar(context,
                                                                    //     text: "Remove Space from  Mobile number");
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.delete,
                                                                color: Theme.of(context).colorScheme.primary),
                                                            onPressed: () {
                                                              _removeMember(index);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              Padding(
                                                padding:const EdgeInsets.all(8.0),
                                                child: TextButton(
                                                  onPressed: _addMember,
                                                  style: TextButton.styleFrom(
                                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min, // Ensures the button fits the content
                                                    children: [
                                                      Icon(
                                                        Icons.add_box_rounded,
                                                        color: Theme.of(context).colorScheme.primary, // Replace with your desired icon
                                                        size: 20,
                                                      ),
                                                      const SizedBox(width:8), // Adds spacing between the icon and text
                                                      Text('Add Member',
                                                        style: TextStyle(
                                                          color:Theme.of(context).colorScheme.primary,
                                                          fontSize: 16,
                                                          fontFamily:'Poppins-Medium',
                                                          fontWeight:FontWeight.w900,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else if (infoField.propertyLoan !=null) {
                                          int loanFields = infoField.propertyLoan!.madatory ??1;
                                          int bondFields =infoField.mssBond?.madatory ?? 1;
                                          int fdLoanFields =infoField.fdloan?.madatory ?? 1;

                                          //int maxFields = [loanFields, bondFields, fdLoanFields].reduce((a, b) => a > b ? a : b); // Get the max count

                                          // Ensure the list has enough controllers
                                          if (_propertyLoanDetails.length <loanFields) {
                                            _propertyLoanDetails =List.generate(loanFields,(index) => {
                                                'loanno':TextEditingController(),
                                              },
                                            );
                                          }
                                          if (_mssBondDetails.length <bondFields) {
                                            _mssBondDetails = List.generate(bondFields,(index) => {
                                                'mssno':TextEditingController(),
                                              },
                                            );
                                          }
                                          if (_fdloanDetails.length <fdLoanFields) {
                                            _fdloanDetails = List.generate(fdLoanFields,(index) => {
                                                'fdloanno':TextEditingController(),
                                              },
                                            );
                                          }

                                          return Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              Text(
                                                "Add Loan/Bond Details",
                                                style: Theme.of(context).textTheme.bodyLarge,
                                              ),
                                              const SizedBox(height: 10),

                                              // Display Loan No fields first
                                              if (loanFields > 0)
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white, // White background
                                                    borderRadius:BorderRadius.circular(12), // Rounded corners
                                                    border: Border.all(
                                                      // Thin black border
                                                      color: Colors.black26,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 2,),
                                                  padding:const EdgeInsets.all(6),
                                                  child: ExpansionTile(
                                                    title: Text("Property Loan Details",
                                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                        color: Theme.of(context).colorScheme.primary)),
                                                    children: List.generate(loanFields, (index) {
                                                      return buildTextFieldContainer(
                                                          //title: '${infoField.propertyLoan!.label} ${index + 1}',
                                                          label:'Loan No ${index + 1}',
                                                          hint:'Enter ${infoField.propertyLoan!.label}',
                                                          controller:_propertyLoanDetails[index]['loanno']!,
                                                          onChanged: (value) {
                                                            
                                                           _propertyLoanDetails[index]['loanno']!.text = value;
                                                          },
                                                          validator: (value) {
                                                            if (value == null ||value.isEmpty) {
                                                              Fluttertoast.showToast(
                                                                  msg:"Enter Loan No",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity:ToastGravity.CENTER,
                                                                  timeInSecForIosWeb:1,
                                                                  backgroundColor:Colors.black,
                                                                  textColor:Colors.white,
                                                                  fontSize:15.0);
                                                              return "Enter Loan No";
                                                            }else if (_propertyLoanDetails.any((element) => element['loanno']!.text == value && element['loanno'] != _propertyLoanDetails[index]['loanno'])) {
                                                                Fluttertoast.showToast(
                                                                  msg: "Duplicate Loan No is not allowed",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.CENTER,
                                                                  timeInSecForIosWeb: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 15.0,
                                                                );
                                                              return "Duplicate Loan No is not allowed";

                                                              }
                                                            
                                                            return null;
                                                          });
                                                    }),
                                                  ),
                                                ),

                                              // Display MSS No fields second
                                              if (bondFields > 0)
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white, // White background
                                                    borderRadius:BorderRadius.circular(12), // Rounded corners
                                                    border: Border.all(
                                                      // Thin black border
                                                      color: Colors.black26,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 2,),
                                                  padding:const EdgeInsets.all(6),
                                                  child: ExpansionTile(
                                                    title: Text("MSS Bond Details",
                                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                color: Theme.of(context).colorScheme.primary)),
                                                    children: List.generate(bondFields, (index) {
                                                      return buildTextFieldContainer(
                                                          //title: '${infoField.mssBond!.label} ${index + 1}',
                                                          label:'MSS Ticket No ${index + 1}',
                                                          hint:'Enter ${infoField.mssBond!.label}',
                                                          controller:_mssBondDetails[index]['mssno']!,
                                                          onChanged: (value) {
                                                            
                                                           _mssBondDetails[index]['mssno']!.text = value;
                                                          },
                                                          validator: (value) {
                                                            if (value == null ||value.isEmpty) {
                                                              Fluttertoast.showToast(
                                                                  msg:"Enter MSS Ticket No",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity:ToastGravity.CENTER,
                                                                  timeInSecForIosWeb:1,
                                                                  backgroundColor:Colors.black,
                                                                  textColor:Colors.white,
                                                                  fontSize:15.0);
                                                              return "Enter MSS Ticket No";
                                                            }else if (_mssBondDetails.any((element) => element['mssno']!.text == value && element['mssno'] != _mssBondDetails[index]['mssno'])) {
                                                              Fluttertoast.showToast(
                                                                msg: "Duplicate MSS Ticket No is not allowed",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.CENTER,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.black,
                                                                textColor: Colors.white,
                                                                fontSize: 15.0,
                                                              );
                                                              return "Duplicate MSS Ticket No is not allowed";
                                                             
                                                            }
                                                            
                                                            return null;
                                                          });
                                                    }),
                                                  ),
                                                ),

                                              // Display FD Loan No fields third
                                              if (fdLoanFields > 0)
                                                Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white, // White background
                                                    borderRadius:BorderRadius.circular(12), // Rounded corners
                                                    border: Border.all(
                                                      // Thin black border
                                                      color: Colors.black26,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 2,),
                                                  padding:const EdgeInsets.all(6),
                                                  child: ExpansionTile(
                                                    title: Text("FD Loan Details",
                                                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                color: Theme.of(context).colorScheme.primary)),
                                                    children: List.generate(fdLoanFields, (index) {
                                                      return buildTextFieldContainer(
                                                          //title: '${infoField.fdloan!.label} ${index + 1}',
                                                          label:'FD Loan No ${index + 1}',
                                                          hint:'Enter ${infoField.fdloan!.label}',
                                                          controller:_fdloanDetails[index]['fdloanno']!,
                                                          onChanged: (value) {
                                                            
                                                            _fdloanDetails[index]['fdloanno']!.text = value;
                                                          },
                                                          validator: (value) {
                                                            if (value == null ||value.isEmpty) {
                                                              Fluttertoast.showToast(
                                                                  msg:"Enter FD Loan No",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity:ToastGravity.CENTER,
                                                                  timeInSecForIosWeb:1,
                                                                  backgroundColor:Colors.black,
                                                                  textColor:Colors.white,
                                                                  fontSize:15.0);
                                                              return "Enter FD Loan No";
                                                            }else if (_fdloanDetails.any((element) => element['fdloanno']!.text == value && element['fdloanno'] != _fdloanDetails[index]['fdloanno'])) {
                                                                Fluttertoast.showToast(
                                                                  msg: "Duplicate FD Loan No is not allowed",
                                                                  toastLength: Toast.LENGTH_SHORT,
                                                                  gravity: ToastGravity.CENTER,
                                                                  timeInSecForIosWeb: 1,
                                                                  backgroundColor: Colors.black,
                                                                  textColor: Colors.white,
                                                                  fontSize: 15.0,
                                                                );
                                                               return "Duplicate FD Loan No is not allowed";

                                                              } 
                                                            
                                                            return null;
                                                          });
                                                    }),
                                                  ),
                                                ),
                                            ],
                                          );
                                        } else if (infoField.name != 'memno') {
                                          //final controller = _namecontroller;
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextInputfield(
                                              label: infoField.label ?? '',
                                              hint: 'Enter ${infoField.name}',
                                              inputType: const TextInputType.numberWithOptions(decimal: true),
                                              inputAction: TextInputAction.done,
                                              cmncontroller: _amountcontroller,
                                              onSaved: (value) {
                                                // Save the entered amount
                                                _amount = value ?? '0';
                                              },
                                              validator: (value) {
                                                if (value == null ||value.isEmpty) {
                                                  return "field is required";
                                                } else if (double.tryParse(value) ==null) {
                                                  return "Enter a valid number";
                                                } else if (value.contains(' ')) {
                                                  Fluttertoast.showToast(
                                                      msg:"Remove Space from number",
                                                      toastLength:Toast.LENGTH_SHORT,
                                                      gravity:ToastGravity.CENTER,
                                                      timeInSecForIosWeb: 1,
                                                      backgroundColor:Colors.black,
                                                      textColor: Colors.white,
                                                      fontSize: 15.0);
                                                  return "Remove Space from number";
                                                }
                                                return null;
                                              },
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            Container(
                              height: 40,
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Theme(
                                data: MyTheme.buttonStyleTheme,
                                child: ElevatedButton(
                                  onPressed: () {
                                    final additionalInfoProvider = Provider.of<AdditionalInfoProvider>(context,listen: false);

                                    // Check if there are selected options requiring validation
                                    if (additionalInfoProvider.selectedInfo.isNotEmpty) {
                                      if (formkey.currentState?.validate() ??false) {
                                        // Save valid input data
                                        formkey.currentState!.save();
                                        
                                        if (areAllFieldsFilled()) {
                                          // final loandetails =getProperyLoandet();
                                          // log('Property Details: $loandetails');

                                          // final mssbonddet = getMssNo();
                                          // log('Mssbond Details: $mssbonddet');

                                          // final fdloandet = getFdloanNo();
                                          // log('Fdloan Details: $fdloandet');
                                          final memberDetails =getMemberDetails();
                                          log('Member Details: $memberDetails');

                                          final amount = _amount;
                                          log('amount: $amount');
                                            //final loanbond_Det=Loanandbonddet(propertyLoan: loandetails,)
                                            if(additionalInfoProvider.selectedInfo.first.propertyLoan!=null){
                                              loanbonddet = {
                                              'property_loan': getProperyLoandet(), // Property loan details
                                              'mss_bond': getMssNo(),          // MSS bond details
                                              'fdloan': getFdloanNo(),        // FD loan details
                                            };

                                            log('Loan and Bond Details: $loanbonddet');
                                            }else{
                                              loanbonddet={};
                                            log('Loan and Bond Details: $loanbonddet');
                                              
                                            }
                                           

                                          if (memberDetails.isEmpty && amount.isEmpty && loanbonddet.isEmpty) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Please fill all mandatory fields')),
                                            );
                                          } else {
                                            getNextQue(context, proceednxt,memberDetails, amount,loanbonddet);
                                          }
                                        } else {
                                          // Show an error message if validation fails
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Please fill all mandatory fields')),
                                          );
                                        }
                                        ;

                                        // Proceed to the next question
                                      } else {
                                        // Show an error message if validation fails
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Please fill all mandatory fields')),
                                        );
                                      }
                                    } else {
                                      // No additional input required; proceed to the next question
                                      getNextQue(context, proceednxt, [], '',{});
                                    }
                                  },
                                  child: Text('NEXT',
                                    style:Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            // const Center(
                            //     child: Padding(
                            //   padding: EdgeInsets.only(top: 150.0),
                            //   child: CircularProgressIndicator(),
                            // )),
                            FutureBuilder(
                              future: Future.delayed(const Duration(minutes: 1)), // Add a delay of 5 seconds
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==ConnectionState.waiting) {
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
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 60,),
                                        Image.asset(
                                          'assets/errror/no_data_found.png', // Path to your No Data Found image
                                          height: 150,
                                          width: 150,
                                        ),
                                        Text('Something Went Wrong',style: Theme.of(context).textTheme.bodyLarge),
                                        Text('Retry',style: Theme.of(context).textTheme.bodyLarge),
                                        IconButton(
                                            onPressed: () {
                                              getStartquestion(doublelat, doublelong);
                                            },
                                            icon: Icon(
                                              Icons.restart_alt,
                                              size: 45,
                                              color: Theme.of(context).colorScheme.primary,
                                            ))
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
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

  bool areAllFieldsFilled() {
    // Check if all property loan fields are filled
    for (var loanDetail in _propertyLoanDetails) {
      if (loanDetail['loanno']!.text.isEmpty) {
        return false;
      }
    }

    // Check if all MSS Bond fields are filled
    for (var bondDetail in _mssBondDetails) {
      if (bondDetail['mssno']!.text.isEmpty) {
        return false;
      }
    }

    // Check if all FD Loan fields are filled
    for (var fdDetail in _fdloanDetails) {
      if (fdDetail['fdloanno']!.text.isEmpty) {
        return false;
      }
    }

    return true;
  }

  Widget buildTextFieldContainer({
    //String? title,

    required String label,
    required String hint,
    required TextEditingController controller,
    String? Function(String?)? validator, // For custom validation rules
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   title??'',
        //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary,),
        // ),
        TextInputfield(
          label: label,
          hint: hint,
          inputType: TextInputType.text,
          inputAction: TextInputAction.next,
          cmncontroller: controller,
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }

  getNextQue(BuildContext context, String type,List<Map<String, String>> memdet, String? amnt,Map<String, List<Map<String, String>>> loanbond) {
    Livelocationfun.instance.startTracking(
      context: context,
      onLocationUpdate: (position) {
        setState(() {
          doublelat = position.latitude;
          doublelong = position.longitude;
          locationMessage ='Latitude: ${position.latitude}, Longitude: ${position.longitude}';
          log('query screen updateque:$locationMessage');
        });
        //getStartquestion(doublelat,doublelong);
      },
    );
    String selectedValue = selectedFormatNotifier.value;
    if (doublelat != 0 && doublelong != 0) {
      fieldList.add(AdditionalField(mname: mname, memno: mnum, amount: amnt, memdet: memdet));
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
          skip: skip,
          //memberdet: memdet
        );

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
                skip: skip,
                memberdet: memdet,
                amount: amnt,
                loanbond: loanbond);

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
        Provider.of<AdditionalInfoProvider>(context, listen: false).clearSelectedInfo();
        SocietyListFunctions.instance.getSocietyList(doublelat, doublelong, context);
        selectedFormatNotifier.value = '';
        selectedItems.value = {0};

        Navigator.pushAndRemoveUntil(context, Approutes().assignedscreen,
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
                  Provider.of<AdditionalInfoProvider>(context, listen: false).clearSelectedInfo();
                  selectedFormatNotifier.value = '';
                  selectedItems.value = {0};
                  Navigator.pushAndRemoveUntil(context,Approutes().assignedscreen,
                    (Route<dynamic> route) =>false, // Remove all previous routes
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
                      Provider.of<AdditionalInfoProvider>(context,listen: false).clearSelectedInfo();

                      questval = await QuestionsFunctions.instance.fetchQueUpdt(val, context);
                      _amountcontroller.clear();
                      _nocontroller.clear();
                      _amount = '';
                      _memberDetails = [];
                      loanbonddet={};
                      loanbonddet.clear();
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
                        } else if (questval?.single.questatus =='PARTIALLY_COMPLETED') {
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
                      Provider.of<AdditionalInfoProvider>(context,listen: false).clearSelectedInfo();

                      try {
                        questval = await QuestionsFunctions.instance.fetchQueUpdt(val, context);
                        _amount = '';
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
                        } else if (questval?.single.questatus =='PARTIALLY_COMPLETED') {
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
                      getNextQue(context, cmpltdNxt, [], '',{});
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
                child: Text("Inspection not completed,Please answer all questions",
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
                    child: Text('OK',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ),
            ],
          )));
}
