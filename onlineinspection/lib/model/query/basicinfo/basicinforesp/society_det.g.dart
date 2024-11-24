// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society_det.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocietyDet _$SocietyDetFromJson(Map<String, dynamic> json) => SocietyDet(
      socId: (json['soc_id'] as num?)?.toInt(),
      socName: json['soc_name'] as String?,
      regNo: json['reg_no'] as String?,
      circleId: (json['circle_id'] as num?)?.toInt(),
      circleName: json['circle_name'] as String?,
      districtId: (json['district_id'] as num?)?.toInt(),
      districtName: json['district_name'] as String?,
      branchName: json['branch_name'] as String?,
      socClass: json['soc_class'] as String?,
      lastInspectionDate: json['lastInspectionDate'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      inspStatus: json['inspection_status'] as String?,
      activity: (json['activity'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      societyActivity: (json['society_activity'] as List<dynamic>?)
          ?.map((e) => SocietyActivity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SocietyDetToJson(SocietyDet instance) =>
    <String, dynamic>{
      'soc_id': instance.socId,
      'soc_name': instance.socName,
      'reg_no': instance.regNo,
      'circle_id': instance.circleId,
      'circle_name': instance.circleName,
      'district_id': instance.districtId,
      'district_name': instance.districtName,
      'branch_name': instance.branchName,
      'soc_class': instance.socClass,
      'lastInspectionDate': instance.lastInspectionDate,
      'user': instance.user,
      'activity': instance.activity,
      'inspection_status': instance.inspStatus,
      'society_activity': instance.societyActivity,
    };
