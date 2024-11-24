import 'package:json_annotation/json_annotation.dart';

part 'change.g.dart';

@JsonSerializable()
class Change {
  String? pen;
  @JsonKey(name: 'user_id')
  String? userId;
  String? password;
  @JsonKey(name: 'new_password')
  String? newPassword;
  @JsonKey(name: 'retype_password')
  String? retypePassword;

  Change({
    this.pen,
    this.userId,
    this.password,
    this.newPassword,
    this.retypePassword,
  });

  factory Change.fromJson(Map<String, dynamic> json) {
    return _$ChangeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangeToJson(this);
}
