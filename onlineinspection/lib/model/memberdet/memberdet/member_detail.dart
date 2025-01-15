import 'package:json_annotation/json_annotation.dart';

part 'member_detail.g.dart';

@JsonSerializable()
class MemberDetail {
  String? name;
  String? id;

  MemberDetail({this.name, this.id});

  factory MemberDetail.fromJson(Map<String, dynamic> json) {
    return _$MemberDetailFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MemberDetailToJson(this);
}
