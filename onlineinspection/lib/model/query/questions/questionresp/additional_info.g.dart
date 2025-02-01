// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additional_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdditionalInfo _$AdditionalInfoFromJson(Map<String, dynamic> json) =>
    AdditionalInfo(
      label: json['label'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      propertyLoan: json['property_loan'] == null
          ? null
          : PropertyLoan.fromJson(
              json['property_loan'] as Map<String, dynamic>),
      mssBond: json['mss_bond'] == null
          ? null
          : MssBond.fromJson(json['mss_bond'] as Map<String, dynamic>),
      fdloan: json['fdloan'] == null
          ? null
          : Fdloan.fromJson(json['fdloan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AdditionalInfoToJson(AdditionalInfo instance) =>
    <String, dynamic>{
      'label': instance.label,
      'name': instance.name,
      'type': instance.type,
      'property_loan': instance.propertyLoan,
      'mss_bond': instance.mssBond,
      'fdloan': instance.fdloan,
    };
