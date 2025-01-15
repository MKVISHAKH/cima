// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'societyreq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Societyreq _$SocietyreqFromJson(Map<String, dynamic> json) => Societyreq(
      lattitude: (json['lattitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      userId: (json['user_id'] as num?)?.toInt(),
      fdate: json['fromdt'] as String?,
      todate: json['todt'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
      socId: (json['soc_id'] as num?)?.toInt(),
      inspectionId: (json['inspection_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SocietyreqToJson(Societyreq instance) =>
    <String, dynamic>{
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
      'user_id': instance.userId,
      'fromdt': instance.fdate,
      'todt': instance.todate,
      'branch_id': instance.branchId,
      'soc_id': instance.socId,
      'inspection_id': instance.inspectionId,
    };
