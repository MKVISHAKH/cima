import 'package:json_annotation/json_annotation.dart';

part 'notice.g.dart';

@JsonSerializable()
class Notice {
  @JsonKey(name: 'notice_id')
  int? noticeId;
  String? reason;
  int? sno;
  String? description;
  String? filename;
  String? fileurl;

  Notice({
    this.noticeId,
    this.reason,
    this.sno,
    this.description,
    this.filename,
    this.fileurl,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return _$NoticeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NoticeToJson(this);
}
