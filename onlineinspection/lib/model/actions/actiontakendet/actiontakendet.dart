import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'actiontakendet.g.dart';

@JsonSerializable()
class Actiontakendet {
  String? status;
  Data? data;
  String? message;

  Actiontakendet({this.status, this.data, this.message});

  factory Actiontakendet.fromJson(Map<String, dynamic> json) {
    return _$ActiontakendetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActiontakendetToJson(this);
}
