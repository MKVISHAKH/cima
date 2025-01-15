import 'package:json_annotation/json_annotation.dart';

import 'datum.dart';

part 'location_update_list.g.dart';

@JsonSerializable()
class LocationUpdateList {
  String? status;
  List<DatumValue>? data;
  String? message;

  LocationUpdateList({this.status, this.data, this.message});

  factory LocationUpdateList.fromJson(Map<String, dynamic> json) {
    return _$LocationUpdateListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationUpdateListToJson(this);
}
