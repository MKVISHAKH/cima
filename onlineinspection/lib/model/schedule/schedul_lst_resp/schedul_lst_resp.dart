import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'schedul_lst_resp.g.dart';

@JsonSerializable()
class SchedulLstResp {
  String? status;
  List<DatumVal>? data;
  String? message;

  SchedulLstResp({this.status, this.data, this.message});

  factory SchedulLstResp.fromJson(Map<String, dynamic> json) {
    return _$SchedulLstRespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SchedulLstRespToJson(this);
}
