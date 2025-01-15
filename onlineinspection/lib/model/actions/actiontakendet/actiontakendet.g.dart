// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'actiontakendet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Actiontakendet _$ActiontakendetFromJson(Map<String, dynamic> json) =>
    Actiontakendet(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ActiontakendetToJson(Actiontakendet instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
