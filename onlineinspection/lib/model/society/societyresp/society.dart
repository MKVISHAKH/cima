import 'branch.dart';

class Society {
  int? socId;
  String? societyName;
  bool? active;
  List<Branch>? branches;
  Society(
      {this.socId, this.societyName, this.active, this.branches = const []});
  factory Society.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["branches"] ?? []) as List);
    List<Branch> wklylist = tklst.map((e) => Branch.fromJson(e)).toList();
    return Society(
      socId: json["soc_id"],
      societyName: json["society_name"],
      active: json["active"],
      branches: wklylist,
    );
  }
  Map<String, dynamic> toJson() => {
        "soc_id": socId,
        "society_name": societyName,
        "active": active,
        "branches": branches
      };
}
