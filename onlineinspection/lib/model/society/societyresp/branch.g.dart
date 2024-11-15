// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Branch _$BranchFromJson(Map<String, dynamic> json) => Branch(
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchName: json['branch_name'] as String?,
      branchAddress: json['branch_address'] as String?,
      place: json['place'] as String?,
      post: json['post'] as String?,
      pin: (json['pin'] as num?)?.toInt(),
      lattitude: json['lattitude'] as String?,
      longitude: json['longitude'] as String?,
      schedulerId: (json['scheduler_id'] as num?)?.toInt(),
      schDate: json['sch_date'] as String?,
      distance: (json['distance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$BranchToJson(Branch instance) => <String, dynamic>{
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'branch_address': instance.branchAddress,
      'place': instance.place,
      'post': instance.post,
      'pin': instance.pin,
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
      'scheduler_id': instance.schedulerId,
      'sch_date': instance.schDate,
      'distance': instance.distance,
    };
