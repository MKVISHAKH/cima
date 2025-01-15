// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'society_branch_resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocietyBranchResp _$SocietyBranchRespFromJson(Map<String, dynamic> json) =>
    SocietyBranchResp(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DatumBranch.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SocietyBranchRespToJson(SocietyBranchResp instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
