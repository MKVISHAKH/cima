// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataCount _$DataCountFromJson(Map<String, dynamic> json) => DataCount(
      userId: (json['user_id'] as num?)?.toInt(),
      pen: (json['pen'] as num?)?.toInt(),
      inspectionCount: (json['inspections'] as num?)?.toInt(),
      scheduleCount: (json['schedules'] as num?)?.toInt(),
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'],
      districtId: (json['district_id'] as num?)?.toInt(),
      districtName: json['district_name'] as String?,
      talukId: (json['taluk_id'] as num?)?.toInt(),
      talukName: json['taluk_name'] as String?,
      circleId: (json['circle_id'] as num?)?.toInt(),
      unitName: json['unit_name'] as String?,
      roleId: (json['role_id'] as num?)?.toInt(),
      roleName: json['role_name'] as String?,
      active: (json['active'] as num?)?.toInt(),
      createdBy: json['created_by'] as String?,
      updatedBy: json['updated_by'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      accessToken: json['access_token'] as String?,
    );

Map<String, dynamic> _$DataCountToJson(DataCount instance) => <String, dynamic>{
      'user_id': instance.userId,
      'pen': instance.pen,
      'inspections':instance.inspectionCount,
      'schedules':instance.scheduleCount,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'district_id': instance.districtId,
      'district_name': instance.districtName,
      'taluk_id': instance.talukId,
      'taluk_name': instance.talukName,
      'circle_id': instance.circleId,
      'unit_name': instance.unitName,
      'role_id': instance.roleId,
      'role_name': instance.roleName,
      'active': instance.active,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'access_token': instance.accessToken,
    };
