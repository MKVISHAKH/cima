import 'package:onlineinspection/core/hook/hook.dart';

int maxdistScty = 0;

class SocietyListFunctions {
  SocietyListFunctions._internal();

  static SocietyListFunctions instance = SocietyListFunctions._internal();
  SocietyListFunctions factory() {
    return instance;
  }

  ValueNotifier<List<Society>> getScietyListNotifier = ValueNotifier([]);

  ValueNotifier<List<SocietyDet>> getSocietyDetNotifier = ValueNotifier([]);

  Future getSocietyList(double lat, double long, BuildContext context) async {
    try {
      final sharedValue = await SharedPrefManager.instance.getSharedData();
      String? message;
      final busRouteReq = Societyreq(
          userId: sharedValue!.userId, lattitude: lat, longitude: long);
      final societylistresp = await Ciadata().getSociety(busRouteReq);
      if (societylistresp == null) {
        getScietyListNotifier.value.clear();
        getScietyListNotifier.value.addAll([]);
        getScietyListNotifier.notifyListeners();

        if (!context.mounted) return;

        CommonFun.instance.showApierror(context, "Something went wrong");
      } else if (societylistresp.statusCode == 200) {
        final resultAsJson = jsonDecode(societylistresp.toString());
        final sctyListRespVal =
            Societyresp.fromJson(resultAsJson as Map<String, dynamic>);
        message = sctyListRespVal.message;
        if (sctyListRespVal.status == 'success') {
          //print('sucess');
          final itemDet = sctyListRespVal.data?.societies ?? [];
          maxdistScty = sctyListRespVal.data?.maxdist ?? 0;
          //print(item_det.);
          getScietyListNotifier.value.clear();
          getScietyListNotifier.value.addAll(itemDet);
          getScietyListNotifier.notifyListeners();
        } else if (sctyListRespVal.status == 'failure') {
          final itemDet = sctyListRespVal.data?.societies ?? [];
          maxdistScty = sctyListRespVal.data?.maxdist ?? 0;

          getScietyListNotifier.value.clear();
          getScietyListNotifier.value.addAll(itemDet);
          getScietyListNotifier.notifyListeners();

          if (!context.mounted) return;
          CommonFun.instance.showApierror(context, "No Data Found");
        }
      } else if (message == 'Unauthenticated' ||
          societylistresp.statusCode == 401) {
        if (!context.mounted) return;

        CommonFun.instance.signout(context);
      } else if (societylistresp.statusCode == 500) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (societylistresp.statusCode == 408) {
        if (!context.mounted) return;
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getScietyListNotifier.value.clear();
        getScietyListNotifier.value.addAll([]);
        getScietyListNotifier.notifyListeners();
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

  Future<List<SocietyDet>?> getSocietyDet(
      Getbasicinfo val, BuildContext context) async {
    try {
      String? message;

      final societylistresp = await Ciadata().getSocietydet(val);
      if (societylistresp == null) {
        getSocietyDetNotifier.value.clear();
        getSocietyDetNotifier.value.addAll([]);
        getSocietyDetNotifier.notifyListeners();

        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
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
          if (!context.mounted) return [];
          CommonFun.instance.showApierror(context, "No Data Found");
          return [];
        }
      } else if (message == 'Unauthenticated' ||
          societylistresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (societylistresp.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
      } else if (societylistresp.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        getSocietyDetNotifier.value.clear();
        getSocietyDetNotifier.value.addAll([]);
        getSocietyDetNotifier.notifyListeners();
        return [];
      }
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return [];
  }

  Future<List<DatumUser>?> getSocietyUser(BuildContext context) async {
    try {
      final sharevalue = await SharedPrefManager.instance.getSharedData();
      String? message;

      List<DatumUser>? societylist = [];

      final userReq = SocietyUserReq(userId: sharevalue!.userId);
      final resp = await Ciadata().getSocietyUser(userReq);

      if (resp == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        societylist = societylist;
        return societylist;
      } else if (resp.statusCode == 200) {
        final resultAsjson = jsonDecode(resp.toString());
        final regrspval =
            SocietyUserResp.fromJson(resultAsjson as Map<String, dynamic>);

        if (regrspval.status == 'success') {
          final reglist = regrspval.data;
          societylist = reglist;
          return societylist;
        } else if (regrspval.status == 'Failed') {
          if (!context.mounted) return [];
          CommonFun.instance.showApierror(context, "No Data Found");
          final reglist = regrspval.data;
          societylist = reglist;
          return societylist;
        }
      } else if (message == 'Unauthenticated' || resp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (resp.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (resp.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return [];
  }

  Future<List<DatumBranch>?> fetchBranch(socid, BuildContext context) async {
    //final sharevalue = await SharedPrefManager.instance.getSharedData();
    try {
      String? message;

      List<DatumBranch>? branchlist = [];

      final userReq = SocietyBranchReq(socId: socid);
      final resp = await Ciadata().fetchBranch(userReq);

      if (resp == null) {
        branchlist = branchlist;
        return branchlist;
      } else if (resp.statusCode == 200) {
        final resultAsjson = jsonDecode(resp.toString());
        final regrspval =
            SocietyBranchResp.fromJson(resultAsjson as Map<String, dynamic>);

        if (regrspval.status == 'success') {
          final reglist = regrspval.data;
          branchlist = reglist;
          return branchlist;
        } else if (regrspval.status == 'Failed') {
          if (!context.mounted) return [];
          CommonFun.instance.showApierror(context, "No Data Found");
          final reglist = regrspval.data;
          branchlist = reglist;
          return branchlist;
        }
      } else if (message == 'Unauthenticated' || resp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (resp.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not Reachable");

        // showLoginerror(context, 3);
      } else if (resp.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
      }
      //return branchlist;
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return [];
  }
}
