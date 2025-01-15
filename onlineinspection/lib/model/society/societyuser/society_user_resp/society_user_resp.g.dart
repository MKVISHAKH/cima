// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society_user_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocietyUserResp _$SocietyUserRespFromJson(Map<String, dynamic> json) =>
    SocietyUserResp(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DatumUser.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SocietyUserRespToJson(SocietyUserResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
