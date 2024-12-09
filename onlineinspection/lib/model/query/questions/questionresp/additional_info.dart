import 'package:json_annotation/json_annotation.dart';

part 'additional_info.g.dart';

@JsonSerializable()
class AdditionalInfo {
  String? label;
  String? name;
  String? type;

  AdditionalInfo({this.label, this.name, this.type});

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return _$AdditionalInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AdditionalInfoToJson(this);
}
