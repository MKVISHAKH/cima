import 'package:json_annotation/json_annotation.dart';

part 'commonresp.g.dart';

@JsonSerializable()
class Commonresp {
  String? status;
  List<dynamic>? data;
  String? message;

  Commonresp({this.status, this.data, this.message});

  factory Commonresp.fromJson(Map<String, dynamic> json) {
    return _$CommonrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CommonrespToJson(this);
}
