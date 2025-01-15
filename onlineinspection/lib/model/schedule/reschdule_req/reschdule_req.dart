import 'package:json_annotation/json_annotation.dart';

part 'reschdule_req.g.dart';

@JsonSerializable()
class ReschduleReq {
  @JsonKey(name: 'scheduler_id')
  int? schedulerId;
  @JsonKey(name: 'user_id')
  int? userId;

  ReschduleReq({this.schedulerId, this.userId});

  factory ReschduleReq.fromJson(Map<String, dynamic> json) {
    return _$ReschduleReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReschduleReqToJson(this);
}
