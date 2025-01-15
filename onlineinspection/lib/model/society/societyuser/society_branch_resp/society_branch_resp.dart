import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'society_branch_resp.g.dart';

@JsonSerializable()
class SocietyBranchResp {
  String? status;
  List<DatumBranch>? data;
  String? message;

  SocietyBranchResp({this.status, this.data, this.message});

  factory SocietyBranchResp.fromJson(Map<String, dynamic> json) {
    return _$SocietyBranchRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyBranchRespToJson(this);
}
