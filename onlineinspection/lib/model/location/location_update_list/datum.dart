import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class DatumValue {
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'soc_name')
  String? socName;
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'branch_name')
  String? branchName;
  @JsonKey(name: 'user_id')
  int? userId;
  String? name;

  DatumValue({
    this.socId,
    this.socName,
    this.branchId,
    this.branchName,
    this.userId,
    this.name,
  });

  factory DatumValue.fromJson(Map<String, dynamic> json) =>
      _$DatumValueFromJson(json);

  Map<String, dynamic> toJson() => _$DatumValueToJson(this);
}
