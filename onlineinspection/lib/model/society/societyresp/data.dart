import 'society.dart';

class Data {
  List<Society> societies;
  int? maxdist;
  Data({this.societies = const [], this.maxdist});
  factory Data.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["societies"] ?? []) as List);
    List<Society> wklylist = tklst.map((e) => Society.fromJson(e)).toList();
    return Data(
      societies: wklylist,
      maxdist: json["max_distance"],
    );
  }
  Map<String, dynamic> toJson() =>
      {"societies": societies, "max_distance": maxdist};
}
