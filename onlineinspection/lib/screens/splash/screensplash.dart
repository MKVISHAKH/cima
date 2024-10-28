import 'package:onlineinspection/core/hook/hook.dart';


class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    checkUserLogin();
    // gotoLogin();
    super.initState();
  }

  Future<void> checkUserLogin() async {
    // final sharedpref = await SharedPreferences.getInstance();
    // final useLoggedin = sharedpref.getBool(savekeyname);
    // if (useLoggedin == null || useLoggedin == false) {
    //   gotoLogin();
    // } else {
    //   final value = await SharedPrefManager.instance.getSharedData();

    //   if (value!.userId != '') {
    //     await Future.delayed(const Duration(seconds: 3));
    //     //await Wklycollectfn.instance.wklycolctfn();
    //     Navigator.pushReplacement(
    //         _scaffoldKey.currentContext!, Approutes().homescreen);
    //   } else {
    //     gotoLogin();
    //   }
    // }
     gotoLogin();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        _scaffoldKey.currentContext!, Approutes().loginscreen);
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return 
    // Material(
    //   child: SizedBox(
    //     width:MediaQuery.of(context).size.width,
    //     height:MediaQuery.of(context).size.height,
    //     child: Stack(
    //       children: [
    //         Stack(
    //           key: _scaffoldKey,
    //           children: [
    //             Container(
    //             width:MediaQuery.of(context).size.width,
    //             height:MediaQuery.of(context).size.height,
    //             decoration: BoxDecoration(
    //               // color:Theme.of(context).colorScheme.tertiary,
    //               image: DecorationImage(
    //                 image: AssetImage('assets/splash/2527291.jpg'),
    //                 fit: BoxFit.cover
    //                 )
    //             ),
                
    //           ),
    //           ],
    //         )
    //     ],),
    //   )
    // );
    
    Scaffold(
      key: _scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.onPrimary
            ])),
        child: Center(
          child:
          Lottie.asset(
            'assets/animation/splash/Animation - 1729853904649.json',
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height/2
          ),
        ),
      ),
    );
  }
}
