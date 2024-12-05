import 'package:onlineinspection/core/hook/hook.dart';
import 'package:onlineinspection/model/schedule/schedul_lst_resp/schedul_lst_resp.dart';

class SchedulelistFun {
  SchedulelistFun._internal();
  static SchedulelistFun instance = SchedulelistFun._internal();
  SchedulelistFun factory() {
    return instance;
  }

  ValueNotifier<List<DatumVal>> getScheduleListNotifier = ValueNotifier([]);
  ValueNotifier<List<DatumVal>> getScheduleRprtNotifier = ValueNotifier([]);

  Future getScheduleList() async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();

    final schedulReq = Societyreq(
      userId: sharedValue!.userId,
    );
    final scheduleLstresp = await Ciadata().scheduleLst(schedulReq);

    if (scheduleLstresp == null) {
      getScheduleListNotifier.value.clear();
      getScheduleListNotifier.value.addAll([]);
      getScheduleListNotifier.notifyListeners();
    } else if (scheduleLstresp.statusCode == 200) {
      final resultAsJson = jsonDecode(scheduleLstresp.toString());
      final sctyListRespVal =
          SchedulLstResp.fromJson(resultAsJson as Map<String, dynamic>);

      if (sctyListRespVal.status == 'success') {
        //print('sucess');
        final itemDet = sctyListRespVal.data ?? [];
        //print(item_det.);
        getScheduleListNotifier.value.clear();
        getScheduleListNotifier.value.addAll(itemDet);
        getScheduleListNotifier.notifyListeners();
      } else if (sctyListRespVal.status == 'failure') {
        final itemDet = sctyListRespVal.data ?? [];
        getScheduleListNotifier.value.clear();
        getScheduleListNotifier.value.addAll(itemDet);
        getScheduleListNotifier.notifyListeners();
      }
    } else {
      getScheduleListNotifier.value.clear();
      getScheduleListNotifier.value.addAll([]);
      getScheduleListNotifier.notifyListeners();
    }
  }

  Future getSchdlcmpltLst() async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();

    final schedulReq = Societyreq(
      userId: sharedValue!.userId,
    );
    final scheduleLstresp = await Ciadata().schdlRprtcmplt(schedulReq);

    if (scheduleLstresp == null) {
      getScheduleRprtNotifier.value.clear();
      getScheduleRprtNotifier.value.addAll([]);
      getScheduleRprtNotifier.notifyListeners();
    } else if (scheduleLstresp.statusCode == 200) {
      final resultAsJson = jsonDecode(scheduleLstresp.toString());
      final sctyListRespVal =
          SchedulLstResp.fromJson(resultAsJson as Map<String, dynamic>);

      if (sctyListRespVal.status == 'success') {
        //print('sucess');
        final itemDet = sctyListRespVal.data ?? [];
        //print(item_det.);
        getScheduleRprtNotifier.value.clear();
        getScheduleRprtNotifier.value.addAll(itemDet);
        getScheduleRprtNotifier.notifyListeners();
      } else if (sctyListRespVal.status == 'failure') {
        final itemDet = sctyListRespVal.data ?? [];
        getScheduleRprtNotifier.value.clear();
        getScheduleRprtNotifier.value.addAll(itemDet);
        getScheduleRprtNotifier.notifyListeners();
      }
    } else {
      getScheduleRprtNotifier.value.clear();
      getScheduleRprtNotifier.value.addAll([]);
      getScheduleRprtNotifier.notifyListeners();
    }
  }
}
