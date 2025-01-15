// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notice _$NoticeFromJson(Map<String, dynamic> json) => Notice(
      noticeId: (json['notice_id'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      sno: (json['sno'] as num?)?.toInt(),
      description: json['description'] as String?,
      filename: json['filename'] as String?,
      fileurl: json['fileurl'] as String?,
    );

Map<String, dynamic> _$NoticeToJson(Notice instance) => <String, dynamic>{
      'notice_id': instance.noticeId,
      'reason': instance.reason,
      'sno': instance.sno,
      'description': instance.description,
      'filename': instance.filename,
      'fileurl': instance.fileurl,
    };
