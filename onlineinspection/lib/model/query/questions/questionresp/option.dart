import 'package:json_annotation/json_annotation.dart';

part 'option.g.dart';

@JsonSerializable()
class Option {
  String? option;
  int? grade;
  @JsonKey(name: 'action_id')
  dynamic actionId;
  @JsonKey(name: 'sort_order')
  int? sortOrder;

  Option({this.option, this.grade, this.actionId, this.sortOrder});

  factory Option.fromJson(Map<String, dynamic> json) {
    return _$OptionFromJson(json);
  }

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
