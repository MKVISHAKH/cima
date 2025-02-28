import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/core/notification/notification_service.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  NotificationServices notificationServices=NotificationServices();
  String? deviceTkn;
  Sharedpref? sharevalue;
  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value){
      log('devicetoken: $value');
      setState(() {
        deviceTkn=value;
      });
      
    });
    checkUserLogin();

    super.initState();
  }

  Future<void> checkUserLogin() async {
    final sharedPref = await SharedPreferences.getInstance();
    final userLoggedIn = sharedPref.getBool(savekeyname) ?? false;
    FirebaseMessaging messaging=FirebaseMessaging.instance;
    String? deviceTokn;
    
    if (!userLoggedIn) {
      gotoLogin();
    } else {
      sharevalue= await SharedPrefManager.instance.getSharedData();

      if (sharevalue?.userId != 0) {
        await Future.delayed(const Duration(seconds: 3));
    
        final value = await SharedPrefManager.instance.getdeviceinfo();
        final val = await SharedPrefManager.instance.getdeviceTkn();
        final tkn=val.devicetoken;
        if((tkn??"").isEmpty){
        String? token=await messaging.getToken();
            deviceTokn=token;
        }else{
          deviceTokn=val.devicetoken;
        }
        final shareddevice = Deviceinfo(
          userId: sharevalue?.userId??'',
          phone: value.phone,
          deviceid: value.deviceid,
          devicetoken: deviceTokn??'',
          phoneos: value.phoneos,
          androidid: value.androidid??'',
          osversion: value.osversion,
          appversion: value.appversion,
          buildnumber: value.buildnumber,);
          try{
            final deviceinforesp=await Ciadata().deviceInfo(shareddevice);
          final resultAsjson = jsonDecode(deviceinforesp.toString());
          final deviceinfoval = Loginresp.fromJson(resultAsjson as Map<String, dynamic>);
          if (deviceinforesp == null) {
            log("deviceinfo response null");
          } else if (deviceinforesp.statusCode == 200) {
              if(deviceinfoval.status=='success'){
                log("device details added");
              }else{
                log("device details failure");
              }
              if (mounted && _scaffoldKey.currentContext != null) {
                Navigator.pushReplacement(
                  _scaffoldKey.currentContext!,
                  Approutes().homescreen,
                );
              }
            log("device details ${deviceinforesp.statusCode}");
          }else{
            log("device details ${deviceinforesp.statusCode}");

              if (mounted && _scaffoldKey.currentContext != null) {
            Navigator.pushReplacement(
              _scaffoldKey.currentContext!,
              Approutes().homescreen,
            );
          }
          }
          }catch(e){
            if (mounted && _scaffoldKey.currentContext != null) {
          Navigator.pushReplacement(
            _scaffoldKey.currentContext!,
            Approutes().homescreen,
          );
        }
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
              'CO-OPERATIVE INSPECTION MOBILE APP',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontSize: 17),
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
      final deviceid = await DeviceInformation.getdeviceid();
      log(deviceid);
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
      final appver=appversion.split('+');
      final version=appver[0];
      final buildno=appver[1];
      final platformId = await DeviceInformation.initPlatformId();
      log('android id: $platformId');

      /*****************************************/

      final shareddevice = Deviceinfo(
          phone: device,
          deviceid: deviceid,
          //devicetoken: deviceTkn??'',
          phoneos: deviceos,
          screenresolution: devicescreen,
          androidid: platformId??'',
          osversion: deviceversion,
          packagename: packagename,
          appversion: version,
          buildnumber: buildno,);
          
      await SharedPrefManager.instance.setdeviceinfo(shareddevice);
    } catch (e) {
      Navigator.pushReplacement(
        _scaffoldKey.currentContext!,
        Approutes().loginscreen,
      );
    }
  }
}
