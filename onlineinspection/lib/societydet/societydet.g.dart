// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'societydet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Societydet _$SocietydetFromJson(Map<String, dynamic> json) => Societydet(
      schedulerId: (json['scheduler_id'] as num?)?.toInt(),
      schedulerDate: json['scheduler_date'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      socId: (json['soc_id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      lattitude: (json['lattitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$SocietydetToJson(Societydet instance) =>
    <String, dynamic>{
      'scheduler_id': instance.schedulerId,
      'scheduler_date': instance.schedulerDate,
      'user_id': instance.userId,
      'soc_id': instance.socId,
      'branch_id': instance.branchId,
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
    };
