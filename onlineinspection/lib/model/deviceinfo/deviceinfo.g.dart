// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deviceinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deviceinfo _$DeviceinfoFromJson(Map<String, dynamic> json) => Deviceinfo(
      phone: json['phone'] as String?,
      phoneos: json['phoneos'] as String?,
      screenresolution: json['screenresolution'] as String?,
      osversion: json['osversion'] as String?,
      packagename: json['packagename'] as String?,
      appversion: json['appversion'] as String?,
    );

Map<String, dynamic> _$DeviceinfoToJson(Deviceinfo instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'phoneos': instance.phoneos,
      'screenresolution': instance.screenresolution,
      'osversion': instance.osversion,
      'packagename': instance.packagename,
      'appversion': instance.appversion,
    };
