import 'option.dart';

class Datum {
  int? questionId;
  int? inspId;
  dynamic parent;
  String? question;
  int? sortOrder;
  List<Option>? option;
  Datum(
      {this.questionId,
      this.inspId,
      this.parent,
      this.question,
      this.sortOrder,
      this.option = const []});
  factory Datum.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["option"] ?? []) as List);
    List<Option> wklylist = tklst.map((e) => Option.fromJson(e)).toList();
    return Datum(
      questionId: json["question_id"],
      inspId: json["inspection_id"],
      parent: json["parent"],
      question: json["question"],
      sortOrder: json["sort_order"],
      option: wklylist,
    );
  }
  Map<String, dynamic> toJson() => {
        "question_id": questionId,
        "inspection_id":inspId,
        "parent": parent,
        "question": question,
        "sort_order": sortOrder,
        "option": option
      };
}
