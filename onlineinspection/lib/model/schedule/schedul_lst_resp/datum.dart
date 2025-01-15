import 'package:json_annotation/json_annotation.dart';
import 'package:onlineinspection/model/schedule/schedul_lst_resp/notice.dart';

part 'datum.g.dart';

@JsonSerializable()
class DatumVal {
  @JsonKey(name: 'scheduler_id')
  int? schedulerId;
  @JsonKey(name: 'inspection_id')
  int? inspId;
  @JsonKey(name: 'sch_date')
  String? schDate;
  @JsonKey(name: 'attended_date')
  String? cmpltDt;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'soc_name')
  String? socName;
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'branch_name')
  String? branchName;
  @JsonKey(name: 'req_status')
  String? reqStatus;
  int? status;
  @JsonKey(name: 'sch_status')
  int? schStatus;
  @JsonKey(name: 're_status')
  int? reStatus;
  @JsonKey(name: 'inspected_by')
  String? inspectedBy;
  @JsonKey(name: 'inspection_date')
  String? inspecDate;
  @JsonKey(name: 'approve_date')
  String? approveDate;
  @JsonKey(name: 'approved_by')
  String? approveBy;
  @JsonKey(name: 'remarks')
  String? remarks;
  @JsonKey(name: 'notice_status')
  int? noticeStatus;
  @JsonKey(name: 'notice_date')
  String? noticeDate;
  @JsonKey(name: 'notice_generated_by')
  String? noticeGenBy;
  @JsonKey(name: 'notice_remarks')
  String? noticeRemarks;
  @JsonKey(name: 'fileurl')
  String? fileUrl;
  @JsonKey(name: 'filename')
  String? filename;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'sno')
  int? sno;
  @JsonKey(name: 'notice_id')
  int? noticeId;
  @JsonKey(name: 'reason')
  String? reason;
  List<Notice>? notice;
  @JsonKey(name: 'geo_location_update')
  int? geoLocationupdt;

  DatumVal(
      {this.schedulerId,
      this.inspId,
      this.schDate,
      this.cmpltDt,
      this.userId,
      this.socId,
      this.socName,
      this.branchId,
      this.branchName,
      this.reqStatus,
      this.status,
      this.schStatus,
      this.reStatus,
      this.inspectedBy,
      this.inspecDate,
      this.approveDate,
      this.approveBy,
      this.remarks,
      this.noticeStatus,
      this.noticeDate,
      this.noticeGenBy,
      this.noticeRemarks,
      this.fileUrl,
      this.filename,
      this.description,
      this.sno,
      this.noticeId,
      this.reason,
      this.notice = const [],
      this.geoLocationupdt});

  factory DatumVal.fromJson(Map<String, dynamic> json) =>
      _$DatumValFromJson(json);

  Map<String, dynamic> toJson() => _$DatumValToJson(this);
}
