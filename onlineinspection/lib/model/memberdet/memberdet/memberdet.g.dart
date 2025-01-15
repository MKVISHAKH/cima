// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memberdet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Memberdet _$MemberdetFromJson(Map<String, dynamic> json) => Memberdet(
      memberDetails: (json['Member Details'] as List<dynamic>?)
          ?.map((e) => MemberDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MemberdetToJson(Memberdet instance) => <String, dynamic>{
      'Member Details': instance.memberDetails,
    };
