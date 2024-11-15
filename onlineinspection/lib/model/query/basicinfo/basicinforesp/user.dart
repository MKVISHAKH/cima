import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? pen;
  String? name;
  String? mobile;
  String? email;
  @JsonKey(name: 'role_name')
  String? roleName;

  User({this.pen, this.name, this.mobile, this.email, this.roleName});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
