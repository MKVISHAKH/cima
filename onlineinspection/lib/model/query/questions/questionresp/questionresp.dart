import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'questionresp.g.dart';

@JsonSerializable()
class Questionresp {
  String? status;
  List<Datum>? data;
  String? message;

  Questionresp({this.status, this.data, this.message});

  factory Questionresp.fromJson(Map<String, dynamic> json) {
    return _$QuestionrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuestionrespToJson(this);
}
