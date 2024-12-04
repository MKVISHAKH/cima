
import 'package:onlineinspection/core/hook/hook.dart';

int maxdistScty=0;

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
        final itemDet = sctyListRespVal.data?.societies ?? [];
        maxdistScty=sctyListRespVal.data?.maxdist ?? 0;
        //print(item_det.);
        getScietyListNotifier.value.clear();
        getScietyListNotifier.value.addAll(itemDet);
        getScietyListNotifier.notifyListeners();
      } else if (sctyListRespVal.status == 'failure') {

        final itemDet = sctyListRespVal.data?.societies ?? [];
        maxdistScty=sctyListRespVal.data?.maxdist ?? 0;

        getScietyListNotifier.value.clear();
        getScietyListNotifier.value.addAll(itemDet);
        getScietyListNotifier.notifyListeners();
      }
    } else {
      getScietyListNotifier.value.clear();
      getScietyListNotifier.value.addAll([]);
      getScietyListNotifier.notifyListeners();
    }
  }

  Future<List<SocietyDet>?> getSocietyDet(Getbasicinfo val) async {
    final societylistresp = await Ciadata().getSocietydet(val);
    if (societylistresp == null) {
      getSocietyDetNotifier.value.clear();
      getSocietyDetNotifier.value.addAll([]);
      getSocietyDetNotifier.notifyListeners();
      return [];
    } else if (societylistresp.statusCode == 200) {
      final resultAsJson = jsonDecode(societylistresp.toString());
      final busRouteListRespVal =
          Basicinforesp.fromJson(resultAsJson as Map<String, dynamic>);
      if (busRouteListRespVal.status == 'success') {
        //print('sucess');
        final itemDet = busRouteListRespVal.data?.societyDet ?? [];
        //print(item_det.);
        getSocietyDetNotifier.value.clear();
        getSocietyDetNotifier.value.addAll(itemDet);
        getSocietyDetNotifier.notifyListeners();
        //final inspstat = itemDet.single.inspStatus;
        return itemDet;
      } else if (busRouteListRespVal.status == 'failure') {
        final itemDet = busRouteListRespVal.data?.societyDet ?? [];
        getSocietyDetNotifier.value.clear();
        getSocietyDetNotifier.value.addAll(itemDet);
        getSocietyDetNotifier.notifyListeners();
        return [];
      }
    } else {
      getSocietyDetNotifier.value.clear();
      getSocietyDetNotifier.value.addAll([]);
      getSocietyDetNotifier.notifyListeners();
      return [];
    }
    return [];
  }
}
