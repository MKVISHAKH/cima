import 'package:json_annotation/json_annotation.dart';

part 'society_user_req.g.dart';

@JsonSerializable()
class SocietyUserReq {
  @JsonKey(name: 'user_id')
  int? userId;

  SocietyUserReq({this.userId});

  factory SocietyUserReq.fromJson(Map<String, dynamic> json) {
    return _$SocietyUserReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyUserReqToJson(this);
}
