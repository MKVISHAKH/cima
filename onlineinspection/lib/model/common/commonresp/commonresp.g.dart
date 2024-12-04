// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commonresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commonresp _$CommonrespFromJson(Map<String, dynamic> json) => Commonresp(
      status: json['status'] as String?,
      data: (json["data"] ?? []) as List,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CommonrespToJson(Commonresp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
