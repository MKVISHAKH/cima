import 'package:json_annotation/json_annotation.dart';

part 'question_req.g.dart';

@JsonSerializable()
class QuestionReq {
  @JsonKey(name: 'inspection_id')
  int? inspectionId;
  @JsonKey(name: 'user_id')
  int? userId;
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'branch_id')
  int? branchId;
  @JsonKey(name: 'question_id')
  int? questionId;
  String? answer;
  double? lattitude;
  double? longitude;

  QuestionReq({
    this.inspectionId,
    this.userId,
    this.socId,
    this.branchId,
    this.questionId,
    this.answer,
    this.lattitude,
    this.longitude,
  });

  factory QuestionReq.fromJson(Map<String, dynamic> json) {
    return _$QuestionReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuestionReqToJson(this);
}
