import 'package:json_annotation/json_annotation.dart';

part 'societyreq.g.dart';

@JsonSerializable()
class Societyreq {
  double? lattitude;
  double? longitude;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'fromdt')
  String? fdate; // Add 'from_date' field
  @JsonKey(name: 'todt')
  String? todate;
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'inspection_id')
  int? inspectionId;

  Societyreq(
      {this.lattitude,
      this.longitude,
      this.userId,
      this.fdate,
      this.todate,
      this.branchId,
      this.socId,
      this.inspectionId});

  factory Societyreq.fromJson(Map<String, dynamic> json) {
    return _$SocietyreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyreqToJson(this);
}
