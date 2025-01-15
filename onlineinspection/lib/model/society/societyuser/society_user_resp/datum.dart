import 'package:json_annotation/json_annotation.dart';

part 'datum.g.dart';

@JsonSerializable()
class DatumUser {
  @JsonKey(name: 'soc_id')
  int? socId;
  @JsonKey(name: 'society_name')
  String? societyName;

  DatumUser({this.socId, this.societyName});

  factory DatumUser.fromJson(Map<String, dynamic> json) =>
      _$DatumUserFromJson(json);

  get routeName => null;

  Map<String, dynamic> toJson() => _$DatumUserToJson(this);
}
