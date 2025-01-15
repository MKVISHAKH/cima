// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      inspectionId: (json['inspection_id'] as num?)?.toInt(),
      socId: (json['soc_id'] as num?)?.toInt(),
      socName: json['soc_name'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchName: json['branch_name'] as String?,
      inspUserId: (json['insp_user_id'] as num?)?.toInt(),
      inspectedBy: json['inspected_by'] as String?,
      inspectionDate: json['inspection_date'] as String?,
      approveDate: json['approve_date'] as String?,
      approvedBy: json['approved_by'],
      remarks: json['remarks'] as String?,
      noticeStatus: (json['notice_status'] as num?)?.toInt(),
      noticeDate: json['notice_date'] as String?,
      noticeGeneratedBy: json['notice_generated_by'],
      noticeRemarks: json['notice_remarks'] as String?,
      notices: (json['notices'] as List<dynamic>?)
          ?.map((e) => Notice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'inspection_id': instance.inspectionId,
      'soc_id': instance.socId,
      'soc_name': instance.socName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'insp_user_id': instance.inspUserId,
      'inspected_by': instance.inspectedBy,
      'inspection_date': instance.inspectionDate,
      'approve_date': instance.approveDate,
      'approved_by': instance.approvedBy,
      'remarks': instance.remarks,
      'notice_status': instance.noticeStatus,
      'notice_date': instance.noticeDate,
      'notice_generated_by': instance.noticeGeneratedBy,
      'notice_remarks': instance.noticeRemarks,
      'notices': instance.notices,
    };
