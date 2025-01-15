import 'package:json_annotation/json_annotation.dart';

part 'additional_field.g.dart';

@JsonSerializable()
class AdditionalField {
  List<Map<String, String>> memdet;
  String? mname;
  String? memno;
  String? amount;
  String? overdue;

  AdditionalField(
      {this.memdet = const [],
      this.mname,
      this.memno,
      this.amount,
      this.overdue});

  factory AdditionalField.fromJson(Map<String, dynamic> json) {
    return _$AdditionalFieldFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdditionalFieldToJson(this);
}
