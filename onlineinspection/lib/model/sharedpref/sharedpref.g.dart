// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharedpref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sharedpref _$SharedprefFromJson(Map<String, dynamic> json) => Sharedpref(
      status: json['status'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      pen: (json['pen'] as num?)?.toInt(),
      name: json['name'] as String?,
      mobile: json['mobile'] as String?,
      districtid: (json['district_id'] as num?)?.toInt(),
      talukid: (json['taluk_id'] as num?)?.toInt(),
      circleid: (json['circle_id'] as num?)?.toInt(),
      roleid: (json['role_id'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      accesstoken: json['access_token'] as String?,
    );

Map<String, dynamic> _$SharedprefToJson(Sharedpref instance) =>
    <String, dynamic>{
      'status': instance.status,
      'user_id': instance.userId,
      'pen': instance.pen,
      'name': instance.name,
      'mobile': instance.mobile,
      'district_id': instance.districtid,
      'taluk_id': instance.talukid,
      'circle_id': instance.circleid,
      'role_id': instance.roleid,
      'active': instance.active,
      'access_token': instance.accesstoken,
    };
