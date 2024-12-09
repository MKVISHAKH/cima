import 'dart:developer';

import 'package:onlineinspection/core/hook/hook.dart';

class QuestionsFunctions {
  QuestionsFunctions._internal();
  static QuestionsFunctions instance = QuestionsFunctions._internal();
  QuestionsFunctions factory() {
    return instance;
  }

  Future<List<Datum>?> fetchQueStrt(Getbasicinfo val) async {
    List<Datum>? quelist = [];

    final queresp = await Ciadata().getQueStrt(val);
    if (queresp == null) {
      quelist = quelist;
      return quelist;
    } else if (queresp.statusCode == 200) {
      final resultJson = jsonDecode(queresp.toString());
      final details = Questionresp.fromJson(resultJson as Map<String, dynamic>);
      if (details.status == 'success') {
        log('first question fetch success');
        final buslistDet = details.data;
        quelist = buslistDet;
        return quelist;
      } else if (details.status == 'Failed') {
        log('first question fetch failed');
        final buslistDet = details.data;
        quelist = buslistDet;
        return quelist;
      }
    } else {
      log('first question fetch exception');
      quelist = quelist;
      return quelist;
    }
    return quelist;
  }

  Future<List<Datum>?> fetchQueUpdt(QuestionReq val) async {
    List<Datum>? quelist = [];

    final queresp = await Ciadata().getQueUpdt(val);
    if (queresp == null) {
      quelist = quelist;
      return quelist;
    } else if (queresp.statusCode == 200) {
      final resultJson = jsonDecode(queresp.toString());
      final details = Questionresp.fromJson(resultJson as Map<String, dynamic>);
      if (details.status == 'success') {
        log('next question fetch success');
        final buslistDet = details.data;
        quelist = buslistDet;
        return quelist;
      } else if (details.status == 'Failed') {
        log('next question fetch failed');
        final buslistDet = details.data;
        quelist = buslistDet;
        return quelist;
      }
    } else {
      log('next question fetch exception');
      quelist = quelist;
      return quelist;
    }
    return quelist;
  }
}
