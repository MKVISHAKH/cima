import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'basicinforesp.g.dart';

@JsonSerializable()
class Basicinforesp {
  String? status;
  Data? data;
  String? message;

  Basicinforesp({this.status, this.data, this.message});

  factory Basicinforesp.fromJson(Map<String, dynamic> json) {
    return _$BasicinforespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BasicinforespToJson(this);
}
