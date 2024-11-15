import 'package:onlineinspection/core/hook/hook.dart';

class SocietyListFunctions {
  SocietyListFunctions._internal();
  static SocietyListFunctions instance = SocietyListFunctions._internal();
  SocietyListFunctions factory() {
    return instance;
  }

  ValueNotifier<List<Society>> getScietyListNotifier = ValueNotifier([]);

  ValueNotifier<List<SocietyDet>> getSocietyDetNotifier = ValueNotifier([]);

  Future getSocietyList(double lat, double long) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final busRouteReq = Societyreq(
        userId: sharedValue!.userId, lattitude: lat, longitude: long);
    final societylistresp = await Ciadata().getSociety(busRouteReq);
    if (societylistresp == null) {
      getScietyListNotifier.value.clear();
      getScietyListNotifier.value.addAll([]);
      getScietyListNotifier.notifyListeners();
    } else if (societylistresp.statusCode == 200) {
      final resultAsJson = jsonDecode(societylistresp.toString());
      final sctyListRespVal =
          Societyresp.fromJson(resultAsJson as Map<String, dynamic>);
      if (sctyListRespVal.status == 'success') {
        //print('sucess');
        final itemDet = sctyListRespVal.data?.societies??[];
        //print(item_det.);
        getScietyListNotifier.value.clear();
        getScietyListNotifier.value.addAll(itemDet);
        getScietyListNotifier.notifyListeners();
      } else if (sctyListRespVal.status == 'failure') {
        final itemDet = sctyListRespVal.data?.societies??[];
        getScietyListNotifier.value.clear();
        getScietyListNotifier.value.addAll(itemDet);
        getScietyListNotifier.notifyListeners();
      }
    }
  }

  Future getSocietyDet(Getbasicinfo val) async {
    final societylistresp = await Ciadata().getSocietydet(val);
    if (societylistresp == null) {
      getSocietyDetNotifier.value.clear();
      getSocietyDetNotifier.value.addAll([]);
      getSocietyDetNotifier.notifyListeners();
    } else if (societylistresp.statusCode == 200) {
      final resultAsJson = jsonDecode(societylistresp.toString());
      final BusRouteListRespVal =
          Basicinforesp.fromJson(resultAsJson as Map<String, dynamic>);
      if (BusRouteListRespVal.status == 'success') {
        //print('sucess');
        final itemDet = BusRouteListRespVal.data?.societyDet??[];
        //print(item_det.);
        getSocietyDetNotifier.value.clear();
        getSocietyDetNotifier.value.addAll(itemDet);
        getSocietyDetNotifier.notifyListeners();
      } else if (BusRouteListRespVal.status == 'failure') {
        final itemDet = BusRouteListRespVal.data?.societyDet??[];
        getSocietyDetNotifier.value.clear();
        getSocietyDetNotifier.value.addAll(itemDet);
        getSocietyDetNotifier.notifyListeners();
      }
    }
  }
}
