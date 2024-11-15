import 'society_det.dart';

class Data {
  List<SocietyDet> societyDet;
  Data({this.societyDet = const []});
  factory Data.fromJson(Map<String, dynamic> json) {
    var tklst = ((json["society_det"] ?? []) as List);
    List<SocietyDet> wklylist =
        tklst.map((e) => SocietyDet.fromJson(e)).toList();
    return Data(
      societyDet: wklylist,
    );
  }
  Map<String, dynamic> toJson() => {"society_det": societyDet};
}
