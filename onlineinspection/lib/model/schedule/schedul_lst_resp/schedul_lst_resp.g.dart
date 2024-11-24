// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedul_lst_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchedulLstResp _$SchedulLstRespFromJson(Map<String, dynamic> json) =>
    SchedulLstResp(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DatumVal.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SchedulLstRespToJson(SchedulLstResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
