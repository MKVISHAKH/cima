import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class DatumBranch {
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'branch_code')
  dynamic branchCode;
  @JsonKey(name: 'branch_name')
  String? branchName;
  String? lattitude;
  String? longitude;

  DatumBranch({
    this.branchId,
    this.branchCode,
    this.branchName,
    this.lattitude,
    this.longitude,
  });

  factory DatumBranch.fromJson(Map<String, dynamic> json) =>
      _$DatumBranchFromJson(json);

  Map<String, dynamic> toJson() => _$DatumBranchToJson(this);
}
