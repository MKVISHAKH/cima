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
      districtName: json['district_name'] as String?,
      talukid: (json['taluk_id'] as num?)?.toInt(),
      talukName: json['taluk_name'] as String?,
      circleid: (json['circle_id'] as num?)?.toInt(),
      unitName: json['unit_name'] as String?,
      roleid: (json['role_id'] as num?)?.toInt(),
      roleName: json['role_name'] as String?,
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
      'district_name':instance.districtName,
      'taluk_id': instance.talukid,
      'taluk_name':instance.talukName,
      'circle_id': instance.circleid,
      'unit_name':instance.unitName,
      'role_id': instance.roleid,
      'role_name':instance.roleName,
      'active': instance.active,
      'access_token': instance.accesstoken,
    };
