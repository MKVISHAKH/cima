import 'package:json_annotation/json_annotation.dart';

import 'society_activity.dart';
import 'user.dart';

part 'society_det.g.dart';

@JsonSerializable()
class SocietyDet {
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'soc_name')
  String? socName;
  @JsonKey(name: 'reg_no')
  String? regNo;
  @JsonKey(name: 'circle_id')
  int? circleId;
  @JsonKey(name: 'circle_name')
  String? circleName;
  @JsonKey(name: 'district_id')
  int? districtId;
  @JsonKey(name: 'district_name')
  String? districtName;
  @JsonKey(name: 'branch_name')
  String? branchName;
  @JsonKey(name: 'soc_class')
  String? socClass;
  String? lastInspectionDate;
  User? user;
  @JsonKey(name: 'society_activity')
  List<SocietyActivity>? societyActivity;

  SocietyDet({
    this.socId,
    this.socName,
    this.regNo,
    this.circleId,
    this.circleName,
    this.districtId,
    this.districtName,
    this.branchName,
    this.socClass,
    this.lastInspectionDate,
    this.user,
    this.societyActivity,
  });

  factory SocietyDet.fromJson(Map<String, dynamic> json) {
    return _$SocietyDetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyDetToJson(this);
}
