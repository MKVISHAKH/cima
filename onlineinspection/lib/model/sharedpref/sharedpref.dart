import 'package:json_annotation/json_annotation.dart';

part 'sharedpref.g.dart';

@JsonSerializable()
class Sharedpref {
  String? status;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'pen')
  int? pen;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'mobile')
  String? mobile;
  @JsonKey(name: 'district_id')
  int? districtid;
  @JsonKey(name: 'taluk_id')
  int? talukid;
  @JsonKey(name: 'circle_id')
  int? circleid;
  @JsonKey(name: 'role_id')
  int? roleid;
  @JsonKey(name: 'active')
  int? active;
  @JsonKey(name: 'access_token')
  String? accesstoken;

  Sharedpref({
    this.status,
    this.userId,
    this.pen,
    this.name,
    this.mobile,
    this.districtid,
    this.talukid,
    this.circleid,
    this.roleid,
    this.active,
    this.accesstoken,
  });
  Sharedpref.value({
    this.status,
    required this.userId,
    required this.pen,
    required this.name,
    required this.mobile,
    required this.districtid,
    required this.talukid,
    required this.circleid,
    required this.roleid,
    required this.active,
    required this.accesstoken,
  });

  factory Sharedpref.fromJson(Map<String, dynamic> json) {
    return _$SharedprefFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SharedprefToJson(this);
}
