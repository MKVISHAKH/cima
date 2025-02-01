// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fdloan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Fdloan _$FdloanFromJson(Map<String, dynamic> json) => Fdloan(
      label: json['label'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      madatory: (json['madatory'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FdloanToJson(Fdloan instance) => <String, dynamic>{
      'label': instance.label,
      'name': instance.name,
      'type': instance.type,
      'madatory': instance.madatory,
    };
