// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_update_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationUpdateList _$LocationUpdateListFromJson(Map<String, dynamic> json) =>
    LocationUpdateList(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DatumValue.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LocationUpdateListToJson(LocationUpdateList instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
