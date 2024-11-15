// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      option: json['option'] as String?,
      grade: (json['grade'] as num?)?.toInt(),
      actionId: json['action_id'],
      sortOrder: (json['sort_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'option': instance.option,
      'grade': instance.grade,
      'action_id': instance.actionId,
      'sort_order': instance.sortOrder,
    };
