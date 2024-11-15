import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  @JsonKey(name: 'user_id')
  int? userId;
  int? pen;
  String? name;
  String? mobile;
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
  String? updatedBy;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;
  @JsonKey(name: 'access_token')
  String? accessToken;

  Data({
    this.userId,
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
    this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
