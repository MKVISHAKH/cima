import 'option.dart';

class Datum {
  String? questatus;
  int? questionId;
  int? inspId;
  dynamic parent;
  String? question;
  String? sortOrder;
  List<Option>? option;
  String? sno;
  Datum(
      {this.questatus,
      this.questionId,
      this.inspId,
      this.parent,
      this.question,
      this.sortOrder,
      this.option = const [],
      this.sno});
  factory Datum.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["option"] ?? []) as List);
    List<Option> wklylist = tklst.map((e) => Option.fromJson(e)).toList();
    return Datum(
      questatus: json["que_status"],
      questionId: json["question_id"],
      inspId: json["inspection_id"],
      parent: json["parent"],
      question: json["question"],
      sortOrder: json["sort_order"],
      option: wklylist,
      sno: json["sno"],
    );
  }
  Map<String, dynamic> toJson() => {
        "que_status": questatus,
        "question_id": questionId,
        "inspection_id": inspId,
        "parent": parent,
        "question": question,
        "sort_order": sortOrder,
        "option": option,
        "sno": sno
      };
}
