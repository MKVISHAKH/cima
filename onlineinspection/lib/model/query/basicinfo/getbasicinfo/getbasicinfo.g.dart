// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getbasicinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Getbasicinfo _$GetbasicinfoFromJson(Map<String, dynamic> json) => Getbasicinfo(
      schedulerId: (json['scheduler_id'] as num?)?.toInt(),
      schedulerDate: json['scheduler_date'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      socId: (json['soc_id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      lattitude: (json['lattitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      socName: json['society_name'] as String?,
      bName: json['branch_name'] as String?,
      activity: json['activity'] as String?,
    );

Map<String, dynamic> _$GetbasicinfoToJson(Getbasicinfo instance) =>
    <String, dynamic>{
      'scheduler_id': instance.schedulerId,
      'scheduler_date': instance.schedulerDate,
      'user_id': instance.userId,
      'soc_id': instance.socId,
      'society_name': instance.socName,
      'branch_id': instance.branchId,
      'branch_name': instance.bName,
      'activity': instance.activity,
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
    };
