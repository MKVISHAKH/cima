// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reject _$RejectFromJson(Map<String, dynamic> json) => Reject(
      remarks: json['remarks'] as String?,
      reqDate: json['req_date'] as String?,
      rejectedBy: json['rejected_by'] as String?,
      rejectedDate: json['rejected_date'] as String?,
    );

Map<String, dynamic> _$RejectToJson(Reject instance) => <String, dynamic>{
      'remarks': instance.remarks,
      'req_date': instance.reqDate,
      'rejected_by': instance.rejectedBy,
      'rejected_date': instance.rejectedDate,
    };
