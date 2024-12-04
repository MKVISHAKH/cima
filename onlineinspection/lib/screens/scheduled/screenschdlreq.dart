import 'package:onlineinspection/core/hook/hook.dart';

class ScreenSchdlReq extends StatefulWidget {
  const ScreenSchdlReq({super.key, 
  this.bankName,
  this.branch,
  this.inspDt,
  this.schdlId,
  this.socId,this.brId});

  final String? bankName;
  final String? branch;
  final String? inspDt;
  final int? schdlId;
  final int? socId;
  final int? brId;

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
        key: _scafoldkey,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.primary,
                leading: IconButton(
                  icon:  Icon(Icons.arrow_back,
                  color: Theme.of(context).colorScheme.onPrimary,),
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
        body:Center(
            child: ListView(children: [
              Card(
                margin: const EdgeInsets.all(10),
                  elevation: 3,
                color:const Color(0xff1569C7) ,
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
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Reschedule Request Form',
                                  style: Theme.of(context).textTheme.titleMedium,
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
                                      widget.bankName??''
                                    ]),
                                    buildRow([
                                      'Branch',
                                      ':',
                                      widget.branch??''
                                    ]),
                                    buildRow([
                                      'Inspection Date',
                                      ':',
                                      widget.inspDt??''
                                    ]),
                                    
                                  ],
                                ),
  
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 0.0),
                                    child: TextFormField(
                                      controller: _remarkscontroller,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5,
                                      maxLength: 200,
                                      style:
                                          Theme.of(context).textTheme.headlineLarge,
                                      
                                                  
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter Remarks";
                                        } 
                                                  
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                          contentPadding:
                                               EdgeInsets.symmetric(vertical: 15,
                                                  horizontal: 25),
                                          fillColor: Colors.white,
                                          filled: true,
                                          hintText: 'Enter remarks',
                                          
                                          labelStyle: TextStyle(
                                          color: Color.fromARGB(255, 2, 89, 136),
                                          fontSize: 16,
                                          fontFamily: 'Poppins-Medium',
                                          fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                
                                const SizedBox(
                                  height: 10,
                                ),
                
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Theme.of(context).colorScheme.primary,
                                            Theme.of(context).colorScheme.primary,
                                          ])),
                                  child: Theme(
                                    data: MyTheme.buttonStyleTheme,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          final sharedValue = await SharedPrefManager.instance.getSharedData();
                                          final usrId=sharedValue!.userId;
                                            final rmrk=_remarkscontroller.text;

                                            final rscdlReq=Getbasicinfo(schedulerId: widget.schdlId,
                                            userId: usrId,
                                            socId: widget.socId,
                                            branchId: widget.brId,
                                            remarks: rmrk);

                                            remarksFun(rscdlReq);
                                        }
                                      },
                                      child: Text('SUBMIT',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10,),
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
                    )),
              ),
              
            ]),
          ),
      ),
    );
  }
  TableRow buildRow(List<String> cells) => TableRow(
        children: cells.map((cell) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              cell,
              style: Theme.of(context).textTheme.labelMedium
            ),
          );
        }).toList(),
      );

  Future remarksFun(Getbasicinfo val)async{
    final loadingProvider = context.read<LoadingProvider>();

    loadingProvider.toggleLoading();


    final loginResponse = await Ciadata().rescdle(val);

    final resultAsjson = jsonDecode(loginResponse.toString());
    final loginval = Commonresp.fromJson(resultAsjson as Map<String, dynamic>);

    loadingProvider.reset();
    if (loginResponse == null) {
      showLoginerror(_scafoldkey.currentContext!, 1,null);
    } else if (loginResponse.statusCode == 200 &&loginval.status == 'success') {
      final msg=loginval.message;

      Fluttertoast.showToast(
          msg: msg??'',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);

      Navigator.pushReplacement(
          _scafoldkey.currentContext!, Approutes().schdleTabScreen);

      //showLoginerror(_scaffoldKey.currentContext!);
    } else if (loginval.status == 'failure') {
      final msg=loginval.message;
      showLoginerror(_scafoldkey.currentContext!, 2,msg);
    } else {
      
      showLoginerror(_scafoldkey.currentContext!, 3,null);
    }
  }

  Future showLoginerror(BuildContext? context, stat,String? msg) async {
    //print('hi');
    if (stat == 2) {
      Fluttertoast.showToast(
          msg: msg??'',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  
}