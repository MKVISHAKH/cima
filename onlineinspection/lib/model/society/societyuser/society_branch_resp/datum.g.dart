// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatumBranch _$DatumBranchFromJson(Map<String, dynamic> json) => DatumBranch(
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchCode: json['branch_code'],
      branchName: json['branch_name'] as String?,
      lattitude: json['lattitude'] as String?,
      longitude: json['longitude'] as String?,
    );

Map<String, dynamic> _$DatumBranchToJson(DatumBranch instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_code': instance.branchCode,
      'branch_name': instance.branchName,
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
    };
