// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_req.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionReq _$QuestionReqFromJson(Map<String, dynamic> json) => QuestionReq(
      inspectionId: (json['inspection_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      socId: (json['soc_id'] as num?)?.toInt(),
      branchId: (json['branch_id'] as num?)?.toInt(),
      questionId: (json['question_id'] as num?)?.toInt(),
      answer: json['answer'] as String?,
      queStatus: json['que_status'] as String?,
      lattitude: (json['lattitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      skip: json['skip'] as bool?,
      addField: (json['additional_info'] as List<dynamic>?)
          ?.map((e) => AdditionalField.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionReqToJson(QuestionReq instance) =>
    <String, dynamic>{
      'inspection_id': instance.inspectionId,
      'user_id': instance.userId,
      'soc_id': instance.socId,
      'branch_id': instance.branchId,
      'question_id': instance.questionId,
      'que_status': instance.queStatus,
      'answer': instance.answer,
      'lattitude': instance.lattitude,
      'longitude': instance.longitude,
      'skip': instance.skip,
      'additional_info':instance.addField
    };
