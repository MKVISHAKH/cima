import 'package:json_annotation/json_annotation.dart';

part 'society_activity.g.dart';

@JsonSerializable()
class SocietyActivity {
  @JsonKey(name: 'activity_id')
  int? activityId;
  @JsonKey(name: 'activity_name')
  String? activityName;

  SocietyActivity({this.activityId, this.activityName});

  factory SocietyActivity.fromJson(Map<String, dynamic> json) {
    return _$SocietyActivityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyActivityToJson(this);
}
