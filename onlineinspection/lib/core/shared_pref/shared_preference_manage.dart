

import 'package:onlineinspection/core/hook/hook.dart';



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
    await sharedprefes.setString('USERID', value.userId!);
    await sharedprefes.setString('USERTYPE', value.userType!);
    await sharedprefes.setString('USERNAME', value.userName!);
    await sharedprefes.setString('OWNERNAME', value.ownerName!);
    //final jsonString = json.encode(value.toJson());
    // await prefs.setStringList(_key, login);
  }

  Future<Sharedpref?> getSharedData() async {
    final sharedprefs = await SharedPreferences.getInstance();

    final userid = sharedprefs.getString('USERID') ?? '';

    final usertype = sharedprefs.getString('USERTYPE') ?? '';

    final username = sharedprefs.getString('USERNAME') ?? '';

    final ownername = sharedprefs.getString('OWNERNAME') ?? '';
    final valshared = Sharedpref.value(
        userId: userid,
        userType: usertype,
        userName: username,
        ownerName: ownername);
    return valshared;
  }
}
