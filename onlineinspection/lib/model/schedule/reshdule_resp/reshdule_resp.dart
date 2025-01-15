import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'reshdule_resp.g.dart';

@JsonSerializable()
class ReshduleResp {
  String? status;
  Data? data;
  String? message;

  ReshduleResp({this.status, this.data, this.message});

  factory ReshduleResp.fromJson(Map<String, dynamic> json) {
    return _$ReshduleRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ReshduleRespToJson(this);
}
