import 'package:dio/dio.dart';

import '../../core/constants/endpoint_constants.dart';
import '../../core/network/api_response.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/token_storage.dart';

import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import '../models/auth/register_request.dart';
import '../models/auth/verify_otp_request.dart';
import '../models/auth/resend_otp_request.dart';

class AuthService {
  AuthService._();

  static final Dio _dio = DioClient.dio;

  static Future<LoginResponse> login(
    LoginRequest request,
  ) async {
    try {
      final response = await _dio.post(
        EndpointConstants.login,
        data: request.toJson(),
      );

      final login = LoginResponse.fromJson(
        response.data,
      );

      await TokenStorage.saveToken(
        login.accessToken,
      );

      return login;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Login gagal",
      );
    }
  }

  static Future<String> register(
    RegisterRequest request,
  ) async {
    try {
      final response = await _dio.post(
        EndpointConstants.register,
        data: request.toJson(),
      );

      final result = ApiResponse.fromJson(
        response.data,
        null,
      );

      if (!result.success) {
        throw Exception(
          result.message,
        );
      }

      return result.message ??
          "OTP berhasil dikirim";
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Register gagal",
      );
    }
  }

  static Future<void> verifyOtp(
    VerifyOtpRequest request,
  ) async {
    try {
      final response = await _dio.post(
        EndpointConstants.verifyOtp,
        data: request.toJson(),
      );

      final result = ApiResponse.fromJson(
        response.data,
        null,
      );

      if (!result.success) {
        throw Exception(
          result.message,
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Verifikasi OTP gagal",
      );
    }
  }

  static Future<void> resendOtp(
    ResendOtpRequest request,
  ) async {
    try {
      final response = await _dio.post(
        EndpointConstants.resendOtp,
        data: request.toJson(),
      );

      final result = ApiResponse.fromJson(
        response.data,
        null,
      );

      if (!result.success) {
        throw Exception(
          result.message,
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Resend OTP gagal",
      );
    }
  }

  static Future<void> logout() async {
    try {
      // Nanti kalau backend punya endpoint logout,
      // request API bisa ditambahkan di sini.

      await TokenStorage.clearToken();
    } catch (_) {
      await TokenStorage.clearToken();
    }
  }
}