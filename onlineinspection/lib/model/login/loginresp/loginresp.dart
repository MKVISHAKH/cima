import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'loginresp.g.dart';

@JsonSerializable()
class Loginresp {
  String? status;
  Data? data;
  String? message;

  Loginresp({this.status, this.data, this.message});

  factory Loginresp.fromJson(Map<String, dynamic> json) {
    return _$LoginrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginrespToJson(this);
}
