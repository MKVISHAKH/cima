// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatumVal _$DatumFromJson(Map<String, dynamic> json) => DatumVal(
      schedulerId: (json['scheduler_id'] as num?)?.toInt(),
      inspId:(json['inspection_id'] as num?)?.toInt(),
      schDate: json['sch_date'] as String?,
      cmpltDt: json['attended_date'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      socId: (json['soc_id'] as num?)?.toInt(),
      socName: json['soc_name'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchName: json['branch_name'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$DatumToJson(DatumVal instance) => <String, dynamic>{
      'scheduler_id': instance.schedulerId,
      'inspection_id':instance.inspId,
      'sch_date': instance.schDate,
      'attended_date':instance.cmpltDt,
      'user_id': instance.userId,
      'soc_id': instance.socId,
      'soc_name': instance.socName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'status': instance.status,
    };
