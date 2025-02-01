// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertyLoan _$PropertyLoanFromJson(Map<String, dynamic> json) => PropertyLoan(
      label: json['label'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      madatory: (json['madatory'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PropertyLoanToJson(PropertyLoan instance) =>
    <String, dynamic>{
      'label': instance.label,
      'name': instance.name,
      'type': instance.type,
      'madatory': instance.madatory,
    };
