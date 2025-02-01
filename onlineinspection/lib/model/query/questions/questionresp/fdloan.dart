import 'package:json_annotation/json_annotation.dart';

part 'fdloan.g.dart';

@JsonSerializable()
class Fdloan {
  String? label;
  String? name;
  String? type;
  int? madatory;

  Fdloan({this.label, this.name, this.type, this.madatory});

  factory Fdloan.fromJson(Map<String, dynamic> json) {
    return _$FdloanFromJson(json);
  }

  Map<String, dynamic> toJson() => _$FdloanToJson(this);
}
