import 'package:json_annotation/json_annotation.dart';

part 'deviceinfo.g.dart';

@JsonSerializable()
class Deviceinfo {
  String? phone;
  String? phoneos;
  String? screenresolution;
  String? osversion;
  String? packagename;
  String? appversion;

  Deviceinfo({
    this.phone,
    this.phoneos,
    this.screenresolution,
    this.osversion,
    this.packagename,
    this.appversion,
  });

  factory Deviceinfo.fromJson(Map<String, dynamic> json) {
    return _$DeviceinfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DeviceinfoToJson(this);
}
