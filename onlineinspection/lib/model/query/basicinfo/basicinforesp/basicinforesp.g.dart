// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basicinforesp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Basicinforesp _$BasicinforespFromJson(Map<String, dynamic> json) =>
    Basicinforesp(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$BasicinforespToJson(Basicinforesp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
