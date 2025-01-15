import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'society_user_resp.g.dart';

@JsonSerializable()
class SocietyUserResp {
  String? status;
  List<DatumUser>? data;
  String? message;

  SocietyUserResp({this.status, this.data, this.message});

  factory SocietyUserResp.fromJson(Map<String, dynamic> json) {
    return _$SocietyUserRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyUserRespToJson(this);
}
