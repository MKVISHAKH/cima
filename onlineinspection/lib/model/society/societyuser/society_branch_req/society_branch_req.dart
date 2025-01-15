import 'package:json_annotation/json_annotation.dart';

part 'society_branch_req.g.dart';

@JsonSerializable()
class SocietyBranchReq {
  @JsonKey(name: 'soc_id')
  int? socId;

  SocietyBranchReq({this.socId});

  factory SocietyBranchReq.fromJson(Map<String, dynamic> json) {
    return _$SocietyBranchReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyBranchReqToJson(this);
}
