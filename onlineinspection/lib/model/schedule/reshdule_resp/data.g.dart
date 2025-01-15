// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      title: json['title'] as String?,
      remarks: json['remarks'] as String?,
      requestedDate: json['requested_date'] as String?,
      reject: (json['reject'] as List<dynamic>?)
          ?.map((e) => Reject.fromJson(e as Map<String, dynamic>))
          .toList(),
      approvedBy: json['approved_by'] as String?,
      approvedDate: json['approved_date'] as String?,
      rejectedBy: json['rejected_by'] as String?,
      rejectedDate: json['rejected_date'] as String?,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'title': instance.title,
      'remarks': instance.remarks,
      'requested_date': instance.requestedDate,
      'reject': instance.reject,
      'approved_by': instance.approvedBy,
      'approved_date': instance.approvedDate,
      'rejected_by': instance.rejectedBy,
      'rejected_date': instance.rejectedDate,
    };
