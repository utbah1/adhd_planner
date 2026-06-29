import 'package:dio/dio.dart';

import '../storage/token_storage.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token =
        await TokenStorage.getToken();

    if (token != null &&
        token.isNotEmpty) {
      options.headers["Authorization"] =
          "Bearer $token";
    }

    super.onRequest(
      options,
      handler,
    );
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    super.onResponse(
      response,
      handler,
    );
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    super.onError(
      err,
      handler,
    );
  }
}