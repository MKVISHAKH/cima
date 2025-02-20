// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DatumVal _$DatumValFromJson(Map<String, dynamic> json) => DatumVal(
      schedulerId: (json['scheduler_id'] as num?)?.toInt(),
      inspId: (json['inspection_id'] as num?)?.toInt(),
      schDate: json['sch_date'] as String?,
      cmpltDt: json['attended_date'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      socId: (json['soc_id'] as num?)?.toInt(),
      socName: json['soc_name'] as String?,
      branchId: (json['branch_id'] as num?)?.toInt(),
      branchName: json['branch_name'] as String?,
      reqStatus: json['req_status'] as String?,
      status: (json['status'] as num?)?.toInt(),
      schStatus: (json['sch_status'] as num?)?.toInt(),
      reStatus: (json['re_status'] as num?)?.toInt(),
      inspectedBy: json['inspected_by'] as String?,
      inspecDate: json['inspection_date'] as String?,
      approveDate: json['approve_date'] as String?,
      approveBy: json['approved_by'] as String?,
      remarks: json['remarks'] as String?,
      noticeStatus: (json['notice_status'] as num?)?.toInt(),
      noticeDate: json['notice_date'] as String?,
      noticeGenBy: json['notice_generated_by'] as String?,
      noticeRemarks: json['notice_remarks'] as String?,
      fileUrl: json['fileurl'] as String?,
      filename: json['filename'] as String?,
      description: json['description'] as String?,
      sno: (json['sno'] as num?)?.toInt(),
      noticeId: (json['notice_id'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      notice: (json['notices'] as List<dynamic>?)
              ?.map((e) => Notice.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      geoLocationupdt: (json['geo_location_update'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DatumValToJson(DatumVal instance) => <String, dynamic>{
      'scheduler_id': instance.schedulerId,
      'inspection_id': instance.inspId,
      'sch_date': instance.schDate,
      'attended_date': instance.cmpltDt,
      'user_id': instance.userId,
      'soc_id': instance.socId,
      'soc_name': instance.socName,
      'branch_id': instance.branchId,
      'branch_name': instance.branchName,
      'req_status': instance.reqStatus,
      'status': instance.status,
      'sch_status': instance.schStatus,
      're_status': instance.reStatus,
      'inspected_by': instance.inspectedBy,
      'inspection_date': instance.inspecDate,
      'approve_date': instance.approveDate,
      'approved_by': instance.approveBy,
      'remarks': instance.remarks,
      'notice_status': instance.noticeStatus,
      'notice_date': instance.noticeDate,
      'notice_generated_by': instance.noticeGenBy,
      'notice_remarks': instance.noticeRemarks,
      'fileurl': instance.fileUrl,
      'filename': instance.filename,
      'description': instance.description,
      'sno': instance.sno,
      'notice_id': instance.noticeId,
      'reason': instance.reason,
      'notices': instance.notice,
      'geo_location_update': instance.geoLocationupdt,
    };
