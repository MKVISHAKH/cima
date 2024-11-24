import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  List<int>? activity;

  Activity({this.activity});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return _$ActivityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
