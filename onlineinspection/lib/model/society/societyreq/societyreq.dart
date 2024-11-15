import 'package:json_annotation/json_annotation.dart';

part 'societyreq.g.dart';

@JsonSerializable()
class Societyreq {
  double? lattitude;
  double? longitude;
  @JsonKey(name: 'user_id')
  int? userId;

  Societyreq({this.lattitude, this.longitude, this.userId});

  factory Societyreq.fromJson(Map<String, dynamic> json) {
    return _$SocietyreqFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SocietyreqToJson(this);
}
