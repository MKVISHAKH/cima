import 'package:json_annotation/json_annotation.dart';

part 'reject.g.dart';

@JsonSerializable()
class Reject {
  String? remarks;
  @JsonKey(name: 'req_date')
  String? reqDate;
  @JsonKey(name: 'rejected_by')
  String? rejectedBy;
  @JsonKey(name: 'rejected_date')
  String? rejectedDate;

  Reject({this.remarks, this.reqDate, this.rejectedBy, this.rejectedDate});

  factory Reject.fromJson(Map<String, dynamic> json) {
    return _$RejectFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RejectToJson(this);
}
