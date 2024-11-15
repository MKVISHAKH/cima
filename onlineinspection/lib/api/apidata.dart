import 'package:dio/dio.dart' as dio;
import 'package:onlineinspection/core/hook/hook.dart';

abstract class Apicalls {
  Future<dio.Response<dynamic>?> login(Loginreq value);
  Future<dio.Response<dynamic>?> getSociety(Societyreq value);
  Future<dio.Response<dynamic>?> getSocietydet(Getbasicinfo value);
  Future<dio.Response<dynamic>?> getQueStrt(Getbasicinfo value);
  Future<dio.Response<dynamic>?> getQueUpdt(QuestionReq value);
}

class Ciadata extends Apicalls {
  final dio.Dio dioclient = dio.Dio();
  final url = Url();

  Ciadata() {
    dioclient.options = dio.BaseOptions(
      baseUrl: url.baseUrl,
      responseType: dio.ResponseType.plain,
    );
  }

  @override
  Future<dio.Response<dynamic>?> login(Loginreq value) async {
    try {
      final result = await dioclient.post(
        url.loginUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<dio.Response<dynamic>?> getSociety(Societyreq value) async {
    try {
      final result = await dioclient.post(
        url.societyUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<dio.Response?> getSocietydet(Getbasicinfo value) async {
    try {
      final result = await dioclient.post(
        url.sctyDetUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<dio.Response?> getQueStrt(Getbasicinfo value) async {
    try {
      final result = await dioclient.post(
        url.questrtUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<dio.Response?> getQueUpdt(QuestionReq value) async {
    try {
      final result = await dioclient.post(
        url.queupdtUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }
}
