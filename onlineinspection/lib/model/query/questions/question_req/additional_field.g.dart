// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalField _$AdditionalFieldFromJson(Map<String, dynamic> json) =>
    AdditionalField(
      memdet: (json['memdet'] as List<dynamic>?)
              ?.map((e) => Map<String, String>.from(e as Map))
              .toList() ??
          const [],
      mname: json['mname'] as String?,
      memno: json['memno'] as String?,
      amount: json['amount'] as String?,
      overdue: json['overdue'] as String?,
    );

Map<String, dynamic> _$AdditionalFieldToJson(AdditionalField instance) =>
    <String, dynamic>{
      'memdet': instance.memdet,
      'mname': instance.mname,
      'memno': instance.memno,
      'amount': instance.amount,
      'overdue': instance.overdue,
    };
