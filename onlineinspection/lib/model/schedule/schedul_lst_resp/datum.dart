import 'package:json_annotation/json_annotation.dart';

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
  String? status;

  DatumVal({
    this.schedulerId,
    this.inspId,
    this.schDate,
    this.cmpltDt,
    this.userId,
    this.socId,
    this.socName,
    this.branchId,
    this.branchName,
    this.status,
  });

  factory DatumVal.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}
