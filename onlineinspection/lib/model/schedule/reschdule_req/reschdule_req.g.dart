// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reschdule_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReschduleReq _$ReschduleReqFromJson(Map<String, dynamic> json) => ReschduleReq(
      schedulerId: (json['scheduler_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReschduleReqToJson(ReschduleReq instance) =>
    <String, dynamic>{
      'scheduler_id': instance.schedulerId,
      'user_id': instance.userId,
    };
