import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'change_resp.g.dart';

@JsonSerializable()
class ChangeResp {
  String? status;
  Data? data;
  String? message;

  ChangeResp({this.status, this.data, this.message});

  factory ChangeResp.fromJson(Map<String, dynamic> json) {
    return _$ChangeRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ChangeRespToJson(this);
}
