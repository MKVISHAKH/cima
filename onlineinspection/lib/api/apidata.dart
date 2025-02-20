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
  Future<dio.Response<dynamic>?> frgtusrName(ChangeReq value);
  Future<dio.Response<dynamic>?> frgtusevrfy(ChangeReq value);
  Future<dio.Response<dynamic>?> rescdle(Getbasicinfo value);
  Future<dio.Response<dynamic>?> getSocietyUser(SocietyUserReq value);
  Future<dio.Response<dynamic>?> fetchBranch(SocietyBranchReq value);
  Future<dio.Response<dynamic>?> schdlActionRprtcmplt(Societyreq value);
  Future<dio.Response<dynamic>?> noticeListView(Societyreq value);
  Future<dio.Response<dynamic>?> dwnldNotice(String? val);
  Future<dio.Response<dynamic>?> rschdlreq(ReschduleReq value);
  Future<dio.Response<dynamic>?> locationupdtList(Societyreq value);
  Future<dio.Response<dynamic>?> locationUpdt(QuestionReq value);
  Future<dio.Response<dynamic>?> deviceInfo(Deviceinfo value);
  Future<dio.Response<dynamic>?> dashboardCount(ChangeReq value);


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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response<dynamic>?> getSociety(Societyreq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.societyUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> getSocietydet(Getbasicinfo value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.sctyDetUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> getQueStrt(Getbasicinfo value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.questrtUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> getQueUpdt(QuestionReq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.queupdtUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> changePswd(ChangeReq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.chngPswdUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
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
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> scheduleLst(Societyreq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.scheduleLstUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> schdlRprtcmplt(Societyreq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.schdlrprtUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> dwnldPdf(int? schId) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.get('${url.dwnldPdfUrl}/$schId',
          options: dio.Options(
              responseType: dio.ResponseType.bytes,
              followRedirects: false,
              receiveDataWhenStatusError: true,
              receiveTimeout: const Duration(seconds: 30),
              headers: {
                "Authorization": "Bearer $token",
                "Accept": "application/json"
              }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> frgtusrName(ChangeReq value) async {
    try {
      final result = await dioclient.post(
        url.frgtUsrUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> frgtusevrfy(ChangeReq value) async {
    try {
      final result = await dioclient.post(
        url.frgtUsrvrfyUrl,
        data: value.toJson(),
      );
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> rescdle(Getbasicinfo value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.reshdlUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> getSocietyUser(SocietyUserReq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.societyUserUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> fetchBranch(SocietyBranchReq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.societyBranchUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> schdlActionRprtcmplt(Societyreq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.actionRprtUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> noticeListView(Societyreq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.noticeViewUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> dwnldNotice(String? val) async {
    try {
      final result = await dioclient.get(val!,
          options: dio.Options(
              responseType: dio.ResponseType.bytes,
              followRedirects: false,
              receiveDataWhenStatusError: true,
              receiveTimeout: const Duration(seconds: 30)));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> rschdlreq(ReschduleReq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.rschdlReqUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> locationupdtList(Societyreq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.loctnupdtLstUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }

  @override
  Future<dio.Response?> locationUpdt(QuestionReq value) async {
    final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.loctnUpdtUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
  
  @override
  Future<dio.Response?> deviceInfo(Deviceinfo value) async{
   final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.deviceInfoUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
  
  @override
  Future<dio.Response?> dashboardCount(ChangeReq value) async{
   final sharedValue = await SharedPrefManager.instance.getSharedData();
    final token = sharedValue!.accesstoken;
    try {
      final result = await dioclient.post(url.dashboardUrl,
          data: value.toJson(),
          options: Options(responseType: ResponseType.plain, headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json"
          }));
      return result;
    } on dio.DioException catch (ex) {
      // Check for timeout or other errors
      if (ex.type == DioExceptionType.connectionTimeout) {
        // Return a custom response or throw an exception with more details
        return dio.Response(
          requestOptions: ex.requestOptions,
          statusCode: 408, // HTTP 408 Request Timeout
          statusMessage: "Connection Timeout",
        );
      }

      // Return the error response from DioException
      return dio.Response(
        requestOptions: ex.requestOptions,
        statusCode: ex.response?.statusCode ??
            500, // Default to HTTP 500 if no status code
        statusMessage: ex.message,
        data: ex.response?.data, // Include error data if available
      );
    }
  }
}
