import 'package:onlineinspection/core/hook/hook.dart';

class SchedulelistFun {
  SchedulelistFun._internal();
  static SchedulelistFun instance = SchedulelistFun._internal();
  SchedulelistFun factory() {
    return instance;
  }

  ValueNotifier<List<DatumVal>> getScheduleListNotifier = ValueNotifier([]);
  ValueNotifier<List<DatumVal>> getScheduleRprtNotifier = ValueNotifier([]);
  ValueNotifier<List<DatumVal>> getActionRprtNotifier = ValueNotifier([]);
  ValueNotifier<List<DatumVal>> noticeListNotifierNotifier = ValueNotifier([]);

  Future getScheduleList(BuildContext context) async {
    try {
      final sharedValue = await SharedPrefManager.instance.getSharedData();

      final schedulReq = Societyreq(
        userId: sharedValue!.userId,
      );
      final scheduleLstresp = await Ciadata().scheduleLst(schedulReq);
      String? message;
      if (scheduleLstresp == null) {
        getScheduleListNotifier.value.clear();
        getScheduleListNotifier.value.addAll([]);
        getScheduleListNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
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
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          scheduleLstresp.statusCode == 401) {
        if (!context.mounted) return;

        CommonFun.instance.signout(context);
      } else if (scheduleLstresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (scheduleLstresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getScheduleListNotifier.value.clear();
        getScheduleListNotifier.value.addAll([]);
        getScheduleListNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future getSchdlcmpltLst(BuildContext context) async {
    try {
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      String? message;

      final schedulReq = Societyreq(
        userId: sharedValue!.userId,
      );
      final scheduleLstresp = await Ciadata().schdlRprtcmplt(schedulReq);

      if (scheduleLstresp == null) {
        getScheduleRprtNotifier.value.clear();
        getScheduleRprtNotifier.value.addAll([]);
        getScheduleRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
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
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          scheduleLstresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (scheduleLstresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (scheduleLstresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getScheduleRprtNotifier.value.clear();
        getScheduleRprtNotifier.value.addAll([]);
        getScheduleRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  //sharanya 09/12/2024
  Future getSchdlcmpltLst1(selectedBranchid, selectedSocietyid, fdate, todate,
      BuildContext context) async {
    try {
      String? message;

      final sharedValue = await SharedPrefManager.instance.getSharedData();

      final schedulReq = Societyreq(
          userId: sharedValue!.userId,
          fdate: fdate,
          todate: todate,
          branchId: selectedBranchid,
          socId: selectedSocietyid);
      final scheduleLstresp = await Ciadata().schdlRprtcmplt(schedulReq);

      if (scheduleLstresp == null) {
        getScheduleRprtNotifier.value.clear();
        getScheduleRprtNotifier.value.addAll([]);
        getScheduleRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
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
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          scheduleLstresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (scheduleLstresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (scheduleLstresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getScheduleRprtNotifier.value.clear();
        getScheduleRprtNotifier.value.addAll([]);
        getScheduleRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future getActionRprt(BuildContext context) async {
    try {
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      String? message;

      final schedulReq = Societyreq(
        userId: sharedValue!.userId,
      );
      final scheduleLstresp = await Ciadata().schdlActionRprtcmplt(schedulReq);

      if (scheduleLstresp == null) {
        getActionRprtNotifier.value.clear();
        getActionRprtNotifier.value.addAll([]);
        getActionRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (scheduleLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(scheduleLstresp.toString());
        final sctyListRespVal =
            SchedulLstResp.fromJson(resultAsJson as Map<String, dynamic>);

        if (sctyListRespVal.status == 'success') {
          //print('sucess');
          final itemDet = sctyListRespVal.data ?? [];
          //print(item_det.);
          getActionRprtNotifier.value.clear();
          getActionRprtNotifier.value.addAll(itemDet);
          getActionRprtNotifier.notifyListeners();
        } else if (sctyListRespVal.status == 'failure') {
          final itemDet = sctyListRespVal.data ?? [];
          getActionRprtNotifier.value.clear();
          getActionRprtNotifier.value.addAll(itemDet);
          getActionRprtNotifier.notifyListeners();
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          scheduleLstresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (scheduleLstresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (scheduleLstresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getActionRprtNotifier.value.clear();
        getActionRprtNotifier.value.addAll([]);
        getActionRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future getActionRprt1(selectedBranchid, selectedSocietyid, fdate, todate,
      BuildContext context) async {
    try {
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      String? message;

      final schedulReq = Societyreq(
          userId: sharedValue!.userId,
          fdate: fdate,
          todate: todate,
          branchId: selectedBranchid,
          socId: selectedSocietyid);
      final scheduleLstresp = await Ciadata().schdlActionRprtcmplt(schedulReq);

      if (scheduleLstresp == null) {
        getActionRprtNotifier.value.clear();
        getActionRprtNotifier.value.addAll([]);
        getActionRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (scheduleLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(scheduleLstresp.toString());
        final sctyListRespVal =
            SchedulLstResp.fromJson(resultAsJson as Map<String, dynamic>);

        if (sctyListRespVal.status == 'success') {
          //print('sucess');
          final itemDet = sctyListRespVal.data ?? [];
          //print(item_det.);
          getActionRprtNotifier.value.clear();
          getActionRprtNotifier.value.addAll(itemDet);
          getActionRprtNotifier.notifyListeners();
        } else if (sctyListRespVal.status == 'failure') {
          final itemDet = sctyListRespVal.data ?? [];
          getActionRprtNotifier.value.clear();
          getActionRprtNotifier.value.addAll(itemDet);
          getActionRprtNotifier.notifyListeners();
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          scheduleLstresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (scheduleLstresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (scheduleLstresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getActionRprtNotifier.value.clear();
        getActionRprtNotifier.value.addAll([]);
        getActionRprtNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future noticeViewList(inspectionId, BuildContext context) async {
    try {
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      String? message;

      final schedulReq =
          Societyreq(userId: sharedValue!.userId, inspectionId: inspectionId);
      final scheduleLstresp = await Ciadata().noticeListView(schedulReq);

      if (scheduleLstresp == null) {
        noticeListNotifierNotifier.value.clear();
        noticeListNotifierNotifier.value.addAll([]);
        noticeListNotifierNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (scheduleLstresp.statusCode == 200) {
        final resultAsJson = jsonDecode(scheduleLstresp.toString());
        final sctyListRespVal =
            SchedulLstResp.fromJson(resultAsJson as Map<String, dynamic>);

        if (sctyListRespVal.status == 'success') {
          //print('sucess');
          final itemDet = sctyListRespVal.data ?? [];
          //print(item_det.);
          noticeListNotifierNotifier.value.clear();
          noticeListNotifierNotifier.value.addAll(itemDet);
          noticeListNotifierNotifier.notifyListeners();
        } else if (sctyListRespVal.status == 'failure') {
          final itemDet = sctyListRespVal.data ?? [];
          noticeListNotifierNotifier.value.clear();
          noticeListNotifierNotifier.value.addAll(itemDet);
          noticeListNotifierNotifier.notifyListeners();
          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          scheduleLstresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (scheduleLstresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (scheduleLstresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        noticeListNotifierNotifier.value.clear();
        noticeListNotifierNotifier.value.addAll([]);
        noticeListNotifierNotifier.notifyListeners();
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
  }

  Future<Data?> resheduleStatus(int? schid, BuildContext context) async {
    try {
      final sharevalue = await SharedPrefManager.instance.getSharedData();
      Data? reschdlstatus;
      final userReq =
          ReschduleReq(userId: sharevalue!.userId, schedulerId: schid);
      final resp = await Ciadata().rschdlreq(userReq);
      String? message;

      if (resp == null) {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "Something went wrong");
        reschdlstatus = reschdlstatus;
        return reschdlstatus;
      } else if (resp.statusCode == 200) {
        final resultAsjson = jsonDecode(resp.toString());
        final regrspval =
            ReshduleResp.fromJson(resultAsjson as Map<String, dynamic>);

        if (regrspval.status == 'success') {
          final reglist = regrspval.data;
          reschdlstatus = reglist;
          return reschdlstatus;
        } else if (regrspval.status == 'Failed') {
          if (!context.mounted) return null;
          CommonFun.instance.showApierror(context, "No Data Found");
          final reglist = regrspval.data;
          reschdlstatus = reglist;
          return reschdlstatus;
        }
      } else if (message == 'Unauthenticated' || resp.statusCode == 401) {
        if (!context.mounted) return null;

        CommonFun.instance.signout(context);
      } else if (resp.statusCode == 500) {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (resp.statusCode == 408) {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return null;
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return null;
  }
}
