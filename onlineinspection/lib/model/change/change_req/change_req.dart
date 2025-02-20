import 'package:json_annotation/json_annotation.dart';

part 'change_req.g.dart';

@JsonSerializable()
class ChangeReq {
  String? pen;
  @JsonKey(name: 'user_id')
  dynamic userId;
  @JsonKey(name: 'ref_id')
  int? refId;
  String? otp;
  String? password;
  @JsonKey(name: 'new_password')
  String? newPassword;
  @JsonKey(name: 'retype_password')
  String? retypePassword;
  String? mobNo;

  ChangeReq(
      {this.pen,
      this.refId,
      this.otp,
      this.userId,
      this.password,
      this.newPassword,
      this.retypePassword,
      this.mobNo});

  factory ChangeReq.fromJson(Map<String, dynamic> json) {
    return _$ChangeReqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangeReqToJson(this);
}
