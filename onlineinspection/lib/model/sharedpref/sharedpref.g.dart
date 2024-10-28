// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharedpref.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sharedpref _$SharedprefFromJson(Map<String, dynamic> json) => Sharedpref(
      status: json['status'] as String?,
      userId: json['user_id'] as String?,
      userType: json['user_type'] as String?,
      userName: json['user_name'] as String?,
      ownerName: json['owner_name'] as String?,
    );

Map<String, dynamic> _$SharedprefToJson(Sharedpref instance) =>
    <String, dynamic>{
      'status': instance.status,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'user_name': instance.userName,
      'owner_name': instance.ownerName,
    };
