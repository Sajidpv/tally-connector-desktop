import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class API {
  final Dio _dio = Dio();
  CancelToken cancelToken = CancelToken();
  // ignore: non_constant_identifier_names
  Map<String, dynamic> DEFAULT_HEADERS = {"Content-Type": "application/json"};

  API() {
    _dio.options.baseUrl = "http://localhost:9000/";
    _dio.options.headers = DEFAULT_HEADERS;
    _dio.interceptors.add(CustomInterceptor(cancelToken: cancelToken));
  }

  Dio get sendRequest => _dio;
}

class CustomInterceptor extends Interceptor {
  final CancelToken cancelToken;

  CustomInterceptor({required this.cancelToken});

  Logger logger = Logger();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    String myErrorMsg = "";

    if (err.error is SocketException) {
      myErrorMsg = "NO INTERNET CONNECTION";
    } else {
      myErrorMsg = await MyDioException.myDioError(err, cancelToken);
    }
    DioException myErr =
        err.copyWith(message: myErrorMsg, response: err.response);

    logger.e(myErr);

    if (myErr.response != null) {
      logger.e(
          "API_Error => ${myErr.response?.statusCode}  ${myErr.requestOptions.uri.toString()}",
          error: myErr);
    }
    // throw myErrorMsg;
    return super.onError(myErr, handler);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Automatically assign cancelToken to each request
    options.cancelToken = cancelToken;

    final requestPath = options.baseUrl;
    final path = options.path;

    logger.i(
      "'${options.method} onRequest => $requestPath$path' \nRequest Body=> '${jsonEncode(options.data)}'",
    );
    logger.i(
      "",
    );
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
}

class MyDioException implements Exception {
  static late String errorMessage;

  static Future<String> myDioError(
      DioException dioError, CancelToken cancelToken) async {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        // PrefData.setLogin(false);
        // g.Get.offAll(EmptyState());
        return errorMessage = 'Request to the server was cancelled.';

      case DioExceptionType.connectionTimeout:
        return errorMessage = 'Connection timed out.';

      case DioExceptionType.receiveTimeout:
        return errorMessage = 'Receiving timeout occurred.';

      case DioExceptionType.sendTimeout:
        return errorMessage = 'Request send timeout.';
      case DioExceptionType.connectionError:
        return errorMessage = 'no internet connection.';

      case DioExceptionType.badResponse:
        return errorMessage = await _handleStatusCode(dioError, cancelToken);

      case DioExceptionType.unknown:
        return errorMessage = 'Unexpected error occurred.';

      default:
        return errorMessage = "Something Went Wrong";
    }
  }

  static Future<String> _handleStatusCode(
      DioException dioError, CancelToken cancelToken) async {
    ///Check if not login then logout....
    // if (!dioError.requestOptions.uri.path.contains(ApiConstants.login) || dioError.requestOptions.uri.path.contains(ApiConstants.register)) {
    //   if (dioError.response != null && dioError.response!.statusCode == 401) {
    //     cancelToken.cancel(["Unauthenticated user"]);

    //     /// That means token is invalid or expired
    //     /// Call logout method
    //     PrefData.setLogin(false);
    //     PrefData.clearStorage();

    //     g.Get.offAll(EmptyState());
    //   }
    // }

    if (dioError.response!.data == null) {
      return "Something Went Wrong";
    }
    if (dioError.response!.data is! Map) {
      return "Something Went Wrong";
    }
    if (dioError.response!.data['message'] != null) {
      final data = dioError.response!.data;
      return data['message'];
    } else {
      return "Something Went Wrong";
    }
  }

  @override
  String toString() => errorMessage;
}
