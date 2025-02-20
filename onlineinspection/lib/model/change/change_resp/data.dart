import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'ref_id')
  int? refId;
  int? pen;
  String? name;
  dynamic mobile;
  String? email;
  @JsonKey(name: 'email_verified_at')
  dynamic emailVerifiedAt;
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'taluk_id')
  int? talukId;
  @JsonKey(name: 'circle_id')
  int? circleId;
  @JsonKey(name: 'role_id')
  int? roleId;
  int? active;
  @JsonKey(name: 'created_by')
  String? createdBy;
  @JsonKey(name: 'updated_by')
  dynamic updatedBy;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  Data({
    this.userId,
    this.refId,
    this.pen,
    this.name,
    this.mobile,
    this.email,
    this.emailVerifiedAt,
    this.districtId,
    this.talukId,
    this.circleId,
    this.roleId,
    this.active,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
