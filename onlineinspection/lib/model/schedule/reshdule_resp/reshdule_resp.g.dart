// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reshdule_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReshduleResp _$ReshduleRespFromJson(Map<String, dynamic> json) => ReshduleResp(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ReshduleRespToJson(ReshduleResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
