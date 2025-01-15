import 'package:json_annotation/json_annotation.dart';

import 'member_detail.dart';

part 'memberdet.g.dart';

@JsonSerializable()
class Memberdet {
  @JsonKey(name: 'Member Details')
  List<MemberDetail>? memberDetails;

  Memberdet({this.memberDetails});

  factory Memberdet.fromJson(Map<String, dynamic> json) {
    return _$MemberdetFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MemberdetToJson(this);
}
