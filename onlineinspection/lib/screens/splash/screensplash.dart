import 'package:onlineinspection/core/hook/hook.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    //WidgetsBinding.instance.addPostFrameCallback((_) {
    checkUserLogin();
    // });
    super.initState();
  }

  Future<void> checkUserLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPref.getBool(savekeyname) ?? false;

    if (!userLoggedIn) {
      gotoLogin();
    } else {
      final value = await SharedPrefManager.instance.getSharedData();

      if (value != null && value.userId != 0) {
        await Future.delayed(const Duration(seconds: 2));
        if (mounted && _scaffoldKey.currentContext != null) {
          Navigator.pushReplacement(
            _scaffoldKey.currentContext!,
            Approutes().homescreen,
          );
        }
      } else {
        gotoLogin();
      }
    }
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted && _scaffoldKey.currentContext != null) {
      Navigator.pushReplacement(
        _scaffoldKey.currentContext!,
        Approutes().loginscreen,
      );
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Lottie.asset(
            'assets/animation/splash/Animation - 1729853904649.json',
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height/2
          ),
        ),
      ),
    );
  }
}
