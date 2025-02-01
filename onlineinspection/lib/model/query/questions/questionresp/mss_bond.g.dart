// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mss_bond.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MssBond _$MssBondFromJson(Map<String, dynamic> json) => MssBond(
      label: json['label'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      madatory: (json['madatory'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MssBondToJson(MssBond instance) => <String, dynamic>{
      'label': instance.label,
      'name': instance.name,
      'type': instance.type,
      'madatory': instance.madatory,
    };
