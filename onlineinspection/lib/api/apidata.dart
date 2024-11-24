import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:onlineinspection/core/hook/hook.dart';

abstract class Apicalls {
  Future<dio.Response<dynamic>?> login(Loginreq value);
  Future<dio.Response<dynamic>?> getSociety(Societyreq value);
  Future<dio.Response<dynamic>?> getSocietydet(Getbasicinfo value);
  Future<dio.Response<dynamic>?> getQueStrt(Getbasicinfo value);
  Future<dio.Response<dynamic>?> getQueUpdt(QuestionReq value);
  Future<dio.Response<dynamic>?> changePswd(ChangeReq value);
  Future<dio.Response<dynamic>?> pswrdVrfy(ChangeReq value);
  Future<dio.Response<dynamic>?> frgtpswrd(ChangeReq value);
  Future<dio.Response<dynamic>?> scheduleLst(Societyreq value);
  Future<dio.Response<dynamic>?> schdlRprtcmplt(Societyreq value);
  Future<dio.Response<dynamic>?> dwnldPdf(int? schId);


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

  @override
  Future<dio.Response?> changePswd(ChangeReq value) async {
    try {
      final result = await dioclient.post(
        url.chngPswdUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<dio.Response?> pswrdVrfy(ChangeReq value) async {
    try {
      final result = await dioclient.post(
        url.frgtPswdvrfyUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<dio.Response?> frgtpswrd(ChangeReq value) async {
    try {
      final result = await dioclient.post(
        url.frgtPswdUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }

  @override
  Future<dio.Response?> scheduleLst(Societyreq value) async {
    try {
      final result = await dioclient.post(
        url.scheduleLstUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }
  
  @override
  Future<dio.Response?> schdlRprtcmplt(Societyreq value) async{
    try {
      final result = await dioclient.post(
        url.schdlrprtUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      return ex.response;
    }
  }
  
  @override
  Future<dio.Response?> dwnldPdf(int? schId) async{
    try {
      final result = await dioclient.get('${
        url.dwnldPdfUrl}/$schId',
        options: dio.Options(
          responseType: dio.ResponseType.bytes,
          followRedirects: false,
          receiveDataWhenStatusError: true,
          receiveTimeout: const Duration(seconds: 40)
        )
      );
      return result;
    } on dio.DioException catch (ex) {
      if (ex.type ==
          DioException.connectionTimeout(
            timeout: const Duration(seconds: 30),
            requestOptions: ex.requestOptions,
          )) {
        throw Exception("Connection Timeout");
      }

      throw Exception(ex.message);
    }
  }
}
