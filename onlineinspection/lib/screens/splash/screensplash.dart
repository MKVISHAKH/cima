import 'dart:developer';

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
        await Future.delayed(const Duration(seconds: 3));
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
    await Future.delayed(const Duration(seconds: 3));
    if (mounted && _scaffoldKey.currentContext != null) {
      Navigator.pushReplacement(
        _scaffoldKey.currentContext!,
        Approutes().loginscreen,
      );
      getdeviceinform();
    }
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          key: _scaffoldKey,
          body: Center(
            child: Text(
              'CO-OPERATIVE INSPECTION APP',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            // Lottie.asset(
            //   'assets/animation/splash/Animation - 1729853904649.json',
            //   width: MediaQuery.of(context).size.width,
            //   //height: MediaQuery.of(context).size.height/2
            // ),
          ),
        ),
      ],
    );
  }

  Future<void> getdeviceinform() async {
    try {
      /*************deviceinfo*****************/
      final device = await DeviceInformation.getdeviceinfo();
      log(device);
      final deviceos = await DeviceInformation.getOSdetails();
      log(deviceos);
      final devicescreen = await DeviceInformation.getScreenResolution();
      log(devicescreen);
      final deviceversion = await DeviceInformation.getDeviceVersion();
      log(deviceversion);
      final packagename = await Appinfo.getpackageName();
      log(packagename);
      final appversion = await Appinfo.getappVersion();
      log(appversion);
      /*****************************************/

      final shareddevice = Deviceinfo(
          phone: device,
          phoneos: deviceos,
          screenresolution: devicescreen,
          osversion: deviceversion,
          packagename: packagename,
          appversion: appversion);
      await SharedPrefManager.instance.setdeviceinfo(shareddevice);
    } catch (e) {
      Navigator.pushReplacement(
        _scaffoldKey.currentContext!,
        Approutes().loginscreen,
      );
    }
  }
}
