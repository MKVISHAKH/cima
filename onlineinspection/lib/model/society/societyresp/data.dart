import 'society.dart';

class Data {
  List<Society> societies;
  Data({this.societies = const []});
  factory Data.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["societies"] ?? []) as List);
    List<Society> wklylist = tklst.map((e) => Society.fromJson(e)).toList();
    return Data(
      societies: wklylist,
    );
  }
  Map<String, dynamic> toJson() => {"societies": societies};
}
