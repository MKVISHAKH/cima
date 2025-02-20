// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deviceinfo _$DeviceinfoFromJson(Map<String, dynamic> json) => Deviceinfo(
      userId: json['user_id'] as dynamic,
      phone: json['device_model'] as String?,
      devicetoken: json['device_token'] as String?,
      deviceid: json['device_id'] as String?,
      phoneos: json['platform'] as String?,
      screenresolution: json['screenresolution'] as String?,
      androidid: json['android_id'] as String?,     
      osversion: json['osversion'] as String?,
      packagename: json['packagename'] as String?,
      appversion: json['app_version'] as String?,
      buildnumber: json['build_number'] as String?,
    );

Map<String, dynamic> _$DeviceinfoToJson(Deviceinfo instance) =>
    <String, dynamic>{
      'user_id':instance.userId,
      'device_model': instance.phone,
      'device_token':instance.devicetoken,
      'device_id':instance.deviceid,
      'platform': instance.phoneos,
      'screenresolution': instance.screenresolution,
      'android_id':instance.androidid,
      'osversion': instance.osversion,
      'packagename': instance.packagename,
      'app_version': instance.appversion,
      'build_number': instance.buildnumber,
    };
