// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatumUser _$DatumUserFromJson(Map<String, dynamic> json) => DatumUser(
      socId: (json['soc_id'] as num?)?.toInt(),
      societyName: json['society_name'] as String?,
    );

Map<String, dynamic> _$DatumUserToJson(DatumUser instance) => <String, dynamic>{
      'soc_id': instance.socId,
      'society_name': instance.societyName,
    };
