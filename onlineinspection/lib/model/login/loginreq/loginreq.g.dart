// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginreq _$LoginreqFromJson(Map<String, dynamic> json) => Loginreq(
      pen: json['pen'] as String?,
      password: json['password'] as String?,
       phone: json['device_model'] as String?,
      devicetoken: json['device_token'] as String?,
      deviceid: json['device_id'] as String?,
      phoneos: json['platform'] as String?,
      androidid: json['android_id'] as String?,     
      osversion: json['osversion'] as String?,
      appversion: json['app_version'] as String?,
      buildnumber: json['build_number'] as String?,
    );

Map<String, dynamic> _$LoginreqToJson(Loginreq instance) => <String, dynamic>{
      'pen': instance.pen,
      'password': instance.password,
      'device_model': instance.phone,
      'device_token':instance.devicetoken,
      'device_id':instance.deviceid,
      'platform': instance.phoneos,
      'android_id':instance.androidid,
      'osversion': instance.osversion,
      'app_version': instance.appversion,
      'build_number': instance.buildnumber,
    };
