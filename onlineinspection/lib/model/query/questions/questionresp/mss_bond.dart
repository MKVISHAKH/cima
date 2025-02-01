import 'package:json_annotation/json_annotation.dart';

part 'mss_bond.g.dart';

@JsonSerializable()
class MssBond {
  String? label;
  String? name;
  String? type;
  int? madatory;

  MssBond({this.label, this.name, this.type, this.madatory});

  factory MssBond.fromJson(Map<String, dynamic> json) {
    return _$MssBondFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MssBondToJson(this);
}
