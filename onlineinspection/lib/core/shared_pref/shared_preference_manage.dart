import 'dart:developer';

import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/model/deviceinfo/deviceinfo.dart';

class SharedPrefManager {
  //---singleton-----
  SharedPrefManager._internal();
  static SharedPrefManager instance = SharedPrefManager._internal();
  SharedPrefManager factory() {
    return instance;
  }
  //----end singleton

  Future<void> addSharedData(Sharedpref value) async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savekeyname, true);
    await sharedprefes.setInt('USERID', value.userId ?? 0);
    await sharedprefes.setInt('PEN', value.pen ?? 0);
    await sharedprefes.setString('NAME', value.name!);
    await sharedprefes.setString('MOBILE', value.mobile!);
    await sharedprefes.setInt('DISTRICTID', value.districtid ?? 0);
    await sharedprefes.setInt('TALUKID', value.talukid ?? 0);
    await sharedprefes.setInt('CIRCLEID', value.circleid ?? 0);
    await sharedprefes.setInt('ROLEID', value.roleid ?? 0);
    await sharedprefes.setInt('ACTIVE', value.active ?? 0);
    await sharedprefes.setString('ACCESSTOKEN', value.accesstoken!);

    //final jsonString = json.encode(value.toJson());
    // await prefs.setStringList(_key, login);
  }

  Future<Sharedpref?> getSharedData() async {
    final sharedprefs = await SharedPreferences.getInstance();

    final userid = sharedprefs.getInt('USERID') ?? 0;

    final pen = sharedprefs.getInt('PEN') ?? 0;

    final name = sharedprefs.getString('NAME') ?? '';

    final mobile = sharedprefs.getString('MOBILE') ?? '';

    final distid = sharedprefs.getInt('DISTRICTID') ?? 0;

    final talid = sharedprefs.getInt('TALUKID') ?? 0;

    final cirid = sharedprefs.getInt('CIRCLEID') ?? 0;

    final rolid = sharedprefs.getInt('ROLEID') ?? 0;

    final active = sharedprefs.getInt('ACTIVE') ?? 0;

    final atkn = sharedprefs.getString('ACCESSTOKEN') ?? '';

    final valshared = Sharedpref.value(
        userId: userid,
        pen: pen,
        name: name,
        mobile: mobile,
        districtid: distid,
        talukid: talid,
        circleid: cirid,
        roleid: rolid,
        active: active,
        accesstoken: atkn);

    return valshared;
  }

  Future<void> setSocietyinfo(Getbasicinfo value) async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savesocinfo, true);
    await sharedprefes.setInt('SCHEDULERID', value.schedulerId ?? 0);
    await sharedprefes.setString('SCHEDULERDATE', value.schedulerDate ?? '');
    await sharedprefes.setInt('SOCID', value.socId ?? 0);
    await sharedprefes.setInt('BRANCHID', value.branchId ?? 0);
    await sharedprefes.setString('BRANCHNAME', value.bName ?? '');
    await sharedprefes.setString('SOCNAME', value.socName ?? '');
  }

  Future<Getbasicinfo> getSocietyinfo() async {
    final sharedprefs = await SharedPreferences.getInstance();
    bool checkValue = sharedprefs.containsKey('SCHEDULERID');
    log('$checkValue');
    final schId = sharedprefs.getInt('SCHEDULERID') ?? 0;
    final schDt = sharedprefs.getString('SCHEDULERDATE') ?? '';
    final soctyId = sharedprefs.getInt('SOCID') ?? 0;
    final brId = sharedprefs.getInt('BRANCHID') ?? 0;
    final brName = sharedprefs.getString('BRANCHNAME') ?? '';
    final soctyName = sharedprefs.getString('SOCNAME') ?? '';

    final infoshared = Getbasicinfo(
        schedulerId: schId,
        schedulerDate: schDt,
        socId: soctyId,
        branchId: brId,
        bName: brName,
        socName: soctyName);

    return infoshared;
  }

  Future<void> setdeviceinfo(Deviceinfo value) async {
    final sharedprefes = await SharedPreferences.getInstance();
    await sharedprefes.setBool(savedeviceinfo, true);
    await sharedprefes.setString('DEVICE', value.phone ?? '');
    await sharedprefes.setString('DEVICEOS', value.phoneos ?? '');
    await sharedprefes.setString(
        'SCREENRESOLUTION', value.screenresolution ?? '');
    await sharedprefes.setString('DEVICEVERSION', value.osversion ?? '');
    await sharedprefes.setString('PACKAGENAME', value.packagename ?? '');
    await sharedprefes.setString('APPVERSION', value.appversion ?? '');
  }

  Future<Deviceinfo> getdeviceinfo() async {
    final sharedprefs = await SharedPreferences.getInstance();
    bool checkValue = sharedprefs.containsKey('DEVICE');
    log('$checkValue');
    final device = sharedprefs.getString('DEVICE') ?? '';
    final deviceos = sharedprefs.getString('DEVICEOS') ?? '';
    final screenres = sharedprefs.getString('SCREENRESOLUTION') ?? '';
    final deviceversion = sharedprefs.getString('DEVICEVERSION') ?? '';
    final packagename = sharedprefs.getString('PACKAGENAME') ?? '';
    final appversion = sharedprefs.getString('APPVERSION') ?? '';

    final infoshared = Deviceinfo(
        phone: device,
        phoneos: deviceos,
        screenresolution: screenres,
        osversion: deviceversion,
        packagename: packagename,
        appversion: appversion);

    return infoshared;
  }
}
