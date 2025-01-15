import 'package:json_annotation/json_annotation.dart';

import 'reject.dart';

part 'data.g.dart';

@JsonSerializable()
class Data {
  String? title;
  String? remarks;
  @JsonKey(name: 'requested_date')
  String? requestedDate;
  List<Reject>? reject;
  @JsonKey(name: 'approved_by')
  String? approvedBy;
  @JsonKey(name: 'approved_date')
  String? approvedDate;
  @JsonKey(name: 'rejected_by')
  String? rejectedBy;
  @JsonKey(name: 'rejected_date')
  String? rejectedDate;

  Data(
      {this.title,
      this.remarks,
      this.requestedDate,
      this.reject,
      this.approvedBy,
      this.approvedDate,
      this.rejectedBy,
      this.rejectedDate});

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
