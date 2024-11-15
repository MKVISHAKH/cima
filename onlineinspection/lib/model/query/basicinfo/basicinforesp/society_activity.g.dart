// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society_activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocietyActivity _$SocietyActivityFromJson(Map<String, dynamic> json) =>
    SocietyActivity(
      activityId: (json['activity_id'] as num?)?.toInt(),
      activityName: json['activity_name'] as String?,
    );

Map<String, dynamic> _$SocietyActivityToJson(SocietyActivity instance) =>
    <String, dynamic>{
      'activity_id': instance.activityId,
      'activity_name': instance.activityName,
    };
