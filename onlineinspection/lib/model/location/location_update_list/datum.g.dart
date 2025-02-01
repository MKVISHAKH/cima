// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatumValue _$DatumValueFromJson(Map<String, dynamic> json) => DatumValue(
      socId: (json['soc_id'] as num?)?.toInt(),
      socName: json['soc_name'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchName: json['branch_name'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DatumValueToJson(DatumValue instance) =>
    <String, dynamic>{
      'soc_id': instance.socId,
      'soc_name': instance.socName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'user_id': instance.userId,
      'name': instance.name,
    };
