import 'package:onlineinspection/model/query/questions/questionresp/additional_info.dart';

class Option {
  String? option;
  int? grade;
  dynamic actionId;
  int? sortOrder;
  List<AdditionalInfo>? addInfo;

  Option(
      {this.option,
      this.grade,
      this.actionId,
      this.sortOrder,
      this.addInfo = const []});
  factory Option.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["additional_info"] ?? []) as List);
    List<AdditionalInfo> wklylist =
        tklst.map((e) => AdditionalInfo.fromJson(e)).toList();
    return Option(
      option: json["option"],
      grade: json["grade"],
      actionId: json["action_id"],
      sortOrder: json["sort_order"],
      addInfo: wklylist,
    );
  }
  Map<String, dynamic> toJson() => {
        "option": option,
        "grade": grade,
        "action_id": actionId,
        "sort_order": sortOrder,
        "additional_info": addInfo
      };
}
