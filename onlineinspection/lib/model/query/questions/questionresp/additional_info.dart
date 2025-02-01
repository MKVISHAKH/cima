import 'package:json_annotation/json_annotation.dart';
import 'package:onlineinspection/model/query/questions/questionresp/fdloan.dart';
import 'package:onlineinspection/model/query/questions/questionresp/mss_bond.dart';
import 'package:onlineinspection/model/query/questions/questionresp/property_loan.dart';

part 'additional_info.g.dart';

@JsonSerializable()
class AdditionalInfo {
  String? label;
  String? name;
  String? type;
  @JsonKey(name: 'property_loan')
  PropertyLoan? propertyLoan;
  @JsonKey(name: 'mss_bond')
  MssBond? mssBond;
  Fdloan? fdloan;

  AdditionalInfo(
      {this.label,
      this.name,
      this.type,
      this.propertyLoan,
      this.mssBond,
      this.fdloan});

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return _$AdditionalInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdditionalInfoToJson(this);
}
