import 'package:json_annotation/json_annotation.dart';

part 'additional_field.g.dart';

@JsonSerializable()
class AdditionalField {
  String? memno;
  String? mname;
  String? amount;

  AdditionalField({this.memno, this.mname, this.amount});

  factory AdditionalField.fromJson(Map<String, dynamic> json) {
    return _$AdditionalFieldFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdditionalFieldToJson(this);
}
