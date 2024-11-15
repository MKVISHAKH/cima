// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'societyresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Societyresp _$SocietyrespFromJson(Map<String, dynamic> json) => Societyresp(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SocietyrespToJson(Societyresp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
