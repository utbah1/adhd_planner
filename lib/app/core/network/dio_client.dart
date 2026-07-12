import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import 'dio_interceptor.dart';

class DioClient {
  DioClient._();

  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,

      connectTimeout: const Duration(
        seconds: 10,
      ),

      receiveTimeout: const Duration(
        seconds: 10,
      ),

      sendTimeout: const Duration(
        seconds: 10,
      ),

      responseType: ResponseType.json,

      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  )
    ..interceptors.add(
      DioInterceptor(),
    )
    ..interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
}