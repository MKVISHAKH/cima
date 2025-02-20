import 'package:json_annotation/json_annotation.dart';

part 'loginreq.g.dart';

@JsonSerializable()
class Loginreq {
  String? pen;
  String? password;
  String? phone;
  String? devicetoken;
  String? deviceid;
  String? phoneos;
  String? androidid;
  String? osversion;
  String? appversion;
  String? buildnumber;

  Loginreq({this.pen,
   this.password,
   this.phone,
   this.devicetoken,
   this.deviceid,
   this.phoneos,
   this.androidid,
   this.osversion,
   this.appversion,
   this.buildnumber});

  factory Loginreq.fromJson(Map<String, dynamic> json) {
    return _$LoginreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginreqToJson(this);
}
