// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      userId: (json['user_id'] as num?)?.toInt(),
      pen: (json['pen'] as num?)?.toInt(),
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['email_verified_at'],
      districtId: (json['district_id'] as num?)?.toInt(),
      talukId: (json['taluk_id'] as num?)?.toInt(),
      circleId: (json['circle_id'] as num?)?.toInt(),
      roleId: (json['role_id'] as num?)?.toInt(),
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

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'user_id': instance.userId,
      'pen': instance.pen,
      'name': instance.name,
      'mobile': instance.mobile,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'district_id': instance.districtId,
      'taluk_id': instance.talukId,
      'circle_id': instance.circleId,
      'role_id': instance.roleId,
      'active': instance.active,
      'created_by': instance.createdBy,
      'updated_by': instance.updatedBy,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'access_token': instance.accessToken,
    };
