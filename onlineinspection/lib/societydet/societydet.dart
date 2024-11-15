import 'package:json_annotation/json_annotation.dart';

part 'societydet.g.dart';

@JsonSerializable()
class Societydet {
  @JsonKey(name: 'scheduler_id')
  int? schedulerId;
  @JsonKey(name: 'scheduler_date')
  String? schedulerDate;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'branch_id')
  int? branchId;
  double? lattitude;
  double? longitude;

  Societydet({
    this.schedulerId,
    this.schedulerDate,
    this.userId,
    this.socId,
    this.branchId,
    this.lattitude,
    this.longitude,
  });

  factory Societydet.fromJson(Map<String, dynamic> json) {
    return _$SocietydetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietydetToJson(this);
}
