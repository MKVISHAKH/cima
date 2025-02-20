import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class DataCount {
  @JsonKey(name: 'user_id')
  int? userId;
  int? pen;
  int? inspectionCount;
  int? scheduleCount;
  String? name;
  String? mobile;
  String? email;
  @JsonKey(name: 'email_verified_at')
  dynamic emailVerifiedAt;
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'taluk_id')
  int? talukId;
  @JsonKey(name: 'taluk_name')
  String? talukName;
  @JsonKey(name: 'circle_id')
  int? circleId;
  @JsonKey(name: 'unit_name')
  String? unitName;
  @JsonKey(name: 'role_id')
  int? roleId;
  @JsonKey(name: 'role_name')
  String? roleName;
  int? active;
  @JsonKey(name: 'created_by')
  String? createdBy;
  @JsonKey(name: 'updated_by')
  String? updatedBy;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'access_token')
  String? accessToken;

  DataCount({
    this.userId,
    this.pen,
    this.inspectionCount,
    this.scheduleCount,
    this.name,
    this.mobile,
    this.email,
    this.emailVerifiedAt,
    this.districtId,
    this.districtName,
    this.talukId,
    this.talukName,
    this.circleId,
    this.unitName,
    this.roleId,
    this.roleName,
    this.active,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.accessToken,
  });

  factory DataCount.fromJson(Map<String, dynamic> json) => _$DataCountFromJson(json);

  Map<String, dynamic> toJson() => _$DataCountToJson(this);
}
