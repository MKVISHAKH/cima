import 'dart:developer';

import 'package:onlineinspection/core/hook/hook.dart';

class QuestionsFunctions {
  QuestionsFunctions._internal();
  static QuestionsFunctions instance = QuestionsFunctions._internal();
  QuestionsFunctions factory() {
    return instance;
  }

  Future<List<Datum>?> fetchQueStrt(
      Getbasicinfo val, BuildContext context) async {
    try {
      List<Datum>? quelist = [];
      String? message;

      final queresp = await Ciadata().getQueStrt(val);
      if (queresp == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);

        quelist = quelist;
        return quelist;
      } else if (queresp.statusCode == 200) {
        final resultJson = jsonDecode(queresp.toString());
        final details =
            Questionresp.fromJson(resultJson as Map<String, dynamic>);
        if (details.status == 'success') {
          log('first question fetch success');
          final buslistDet = details.data;
          quelist = buslistDet;
          return quelist;
        } else if (details.status == 'Failed') {
          if (!context.mounted) return [];
          CommonFun.instance.showApierror(context, "Question can't reached");
          log('first question fetch failed');
          final buslistDet = details.data;
          quelist = buslistDet;
          return quelist;
        }
      } else if (message == 'Unauthenticated' || queresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (queresp.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
        return [];
      } else if (queresp.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
        return [];
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
        return [];
      }
      return quelist;
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return [];
  }

  Future<List<Datum>?> fetchQueUpdt(
      QuestionReq val, BuildContext context) async {
    try {
      List<Datum>? quelist = [];
      String? message;
      final queresp = await Ciadata().getQueUpdt(val);
      if (queresp == null) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        quelist = quelist;
        return quelist;
      } else if (queresp.statusCode == 200) {
        final resultJson = jsonDecode(queresp.toString());
        final details =
            Questionresp.fromJson(resultJson as Map<String, dynamic>);
        if (details.status == 'success') {
          log('next question fetch success');
          final buslistDet = details.data;
          quelist = buslistDet;
          return quelist;
        } else if (details.status == 'Failed') {
          log('next question fetch failed');
          if (!context.mounted) return [];
          CommonFun.instance
              .showApierror(context, "Next Question can't reached");
          final buslistDet = details.data;
          quelist = buslistDet;
          return quelist;
        }
      } else if (message == 'Unauthenticated' || queresp.statusCode == 401) {
        if (!context.mounted) return [];

        CommonFun.instance.signout(context);
      } else if (queresp.statusCode == 500) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Sever Not reached");

        // showLoginerror(context, 3);
        return [];
      } else if (queresp.statusCode == 408) {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Connection time out");

        //showLoginerror(context, 4);
        return [];
      } else {
        if (!context.mounted) return [];
        CommonFun.instance.showApierror(context, "Something went wrong");
        //showLoginerror(context, 5);
        return [];
      }
      return quelist;
    } catch (e) {
      if (!context.mounted) return [];

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred')),
      );
    }
    return [];
  }
}
