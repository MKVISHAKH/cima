import 'package:json_annotation/json_annotation.dart';

part 'change_req.g.dart';

@JsonSerializable()
class ChangeReq {
  String? pen;
  @JsonKey(name: 'user_id')
  String? userId;
  String? password;
  @JsonKey(name: 'new_password')
  String? newPassword;
  @JsonKey(name: 'retype_password')
  String? retypePassword;

  ChangeReq({
    this.pen,
    this.userId,
    this.password,
    this.newPassword,
    this.retypePassword,
  });

  factory ChangeReq.fromJson(Map<String, dynamic> json) {
    return _$ChangeReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangeReqToJson(this);
}
