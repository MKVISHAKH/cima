// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Questionresp _$QuestionrespFromJson(Map<String, dynamic> json) => Questionresp(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$QuestionrespToJson(Questionresp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
