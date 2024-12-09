import 'package:json_annotation/json_annotation.dart';

import 'data.dart';

part 'societyresp.g.dart';

@JsonSerializable()
class Societyresp {
  
  String? status;
  Data? data;
  String? message;

  Societyresp({this.status, this.data, this.message});

  factory Societyresp.fromJson(Map<String, dynamic> json) {
    return _$SocietyrespFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyrespToJson(this);
}
