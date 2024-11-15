import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@JsonSerializable()
class Branch {
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'branch_name')
  String? branchName;
  @JsonKey(name: 'branch_address')
  String? branchAddress;
  String? place;
  String? post;
  int? pin;
  String? lattitude;
  String? longitude;
  @JsonKey(name: 'scheduler_id')
  int? schedulerId;
  @JsonKey(name: 'sch_date')
  String? schDate;
  double? distance;

  Branch({
    this.branchId,
    this.branchName,
    this.branchAddress,
    this.place,
    this.post,
    this.pin,
    this.lattitude,
    this.longitude,
    this.schedulerId,
    this.schDate,
    this.distance,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return _$BranchFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
