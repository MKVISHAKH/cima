import 'package:json_annotation/json_annotation.dart';

part 'getbasicinfo.g.dart';

@JsonSerializable()
class Getbasicinfo {
  @JsonKey(name: 'scheduler_id')
  int? schedulerId;
  @JsonKey(name: 'scheduler_date')
  String? schedulerDate;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'society_name')
  String? socName;
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'branch_name')
  String? bName;
  String? activity;
  double? lattitude;
  double? longitude;
  String? remarks;

  Getbasicinfo(
      {this.schedulerId,
      this.schedulerDate,
      this.userId,
      this.socId,
      this.branchId,
      this.lattitude,
      this.longitude,
      this.socName,
      this.bName,
      this.activity,
      this.remarks});
  Getbasicinfo.val(
      {required this.schedulerId,
      required this.schedulerDate,
      required this.userId,
      required this.socId,
      this.socName,
      required this.branchId,
      this.lattitude,
      this.longitude,
      this.bName,
      this.activity,
      this.remarks});

  factory Getbasicinfo.fromJson(Map<String, dynamic> json) {
    return _$GetbasicinfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GetbasicinfoToJson(this);
}
