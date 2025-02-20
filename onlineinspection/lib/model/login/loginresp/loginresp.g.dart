// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginresp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loginresp _$LoginrespFromJson(Map<String, dynamic> json) => Loginresp(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : DataCount.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoginrespToJson(Loginresp instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
