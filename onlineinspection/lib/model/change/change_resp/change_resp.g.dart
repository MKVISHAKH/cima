// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeResp _$ChangeRespFromJson(Map<String, dynamic> json) => ChangeResp(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ChangeRespToJson(ChangeResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
