import 'dart:developer';
import 'package:onlineinspection/core/hook/hook.dart';

class OtpFiled extends StatefulWidget {
  const OtpFiled({super.key});

  @override
  State<OtpFiled> createState() => _OtpFiledState();
}

class _OtpFiledState extends State<OtpFiled> {
  Timer? _timer;

  int remainingsec = 0;

  final time = '00:0-'.obs;

  int start = 180;

  bool wait = false;

  String type = 'REGISTRATION';

  String? otppin;
  OtpFieldController otpController = OtpFieldController();
  @override
  void initState() {
    //checkUserLoggedIn();
    starttimer(start);
    super.initState();
    // setState(() {
    //   wait=false;
    // });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Get.put(TimerController());
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 3,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onSecondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'OTP Verification',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            OTPTextField(
              controller: otpController,
              length: 6,
              width: size.width - 34,
              fieldWidth: 55,
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: Theme.of(context).colorScheme.primary,
                borderColor: const Color(0xFFE1E1E1),
                focusBorderColor: const Color(0xFFE1E1E1),
                enabledBorderColor: const Color(0xFFE1E1E1),
              ),
              style: Theme.of(context).textTheme.labelLarge!,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,

              // onCompleted: (pin) {
              //   //print(otpController);
              //   print("Completed: " + pin);
              // },
              onChanged: (String? pin) {
                if (pin?.length == 6) {
                  //print(pin);
                  otppin = pin;
                  log('$otppin');
                  // final otpreq=Otpvrfyreq.req(
                  //   mobile: widget.mobileNo, otp: pin, type: type);
                  // buildotpvrf(otpreq);
                }
              },
            ),
            const SizedBox(
              height: 15,
            ),
            buildtimer(),
            TextButton(
              onPressed: () {
                if (wait == true) {
                  starttimer(180);
                  setState(() {
                    wait = false;
                  });
                  // final otpreq = Otprsndreq.req(
                  //     mobile: widget.mobileNo, type: type);
                  // buildotpresend(otpreq);
                }
              },
              child: Text(
                'Resend OTP',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                      ])),
              child: Theme(
                data: MyTheme.buttonStyleTheme,
                child: ElevatedButton(
                  onPressed: () async {
                    if (otppin == null) {
                      Fluttertoast.showToast(
                          msg: 'Please Enter OTP',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      // final otpreq = Otpvrfyreq.req(
                      //     mobile: widget.mobileNo,
                      //     otp: otppin,
                      //     type: type);
                      // buildotpvrf(otpreq);
                    }
                  },
                  child: Text('VERIFY',
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  starttimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingsec = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingsec == 0) {
        timer.cancel();
        // wait=false;
        wait = true;
      } else {
        int minutes = remainingsec ~/ 60;
        int seconds = (remainingsec % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingsec--;
      }
    });
  }

  Widget buildtimer() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text('This otp will expired in ',
          style: Theme.of(context).textTheme.bodySmall),
      Obx(() => Center(
            child: Text(time.value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                )),
          ))
    ]);
  }
}
