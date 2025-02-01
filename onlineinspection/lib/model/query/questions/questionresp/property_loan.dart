import 'package:json_annotation/json_annotation.dart';

part 'property_loan.g.dart';

@JsonSerializable()
class PropertyLoan {
  String? label;
  String? name;
  String? type;
  int? madatory;

  PropertyLoan({this.label, this.name, this.type, this.madatory});

  factory PropertyLoan.fromJson(Map<String, dynamic> json) {
    return _$PropertyLoanFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PropertyLoanToJson(this);
}
