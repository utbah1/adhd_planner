import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      final result = ApiResponse<LoginResponse>.fromJson(
        response.data,
        (json) => LoginResponse.fromJson(json),
      );

      if (!result.success || result.data == null) {
        throw Exception(result.message ?? "Login gagal");
      }

      await TokenStorage.saveToken(
          result.data!.accessToken,
      );

      return result.data!;

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

  static Future<LoginResponse> googleLogin(
    String idToken,
  ) async {

    try {

      final response = await _dio.post(

        EndpointConstants.googleLogin,

        data: {
          "id_token": idToken,
        },

      );

      final result =
          ApiResponse<LoginResponse>.fromJson(

        response.data,

        (json) => LoginResponse.fromJson(json),

      );

      if (!result.success ||
          result.data == null) {

        throw Exception(
          result.message ??
              "Google Login gagal",
        );

      }

      await TokenStorage.saveToken(
        result.data!.accessToken,
      );

      return result.data!;

    } on DioException catch (e) {

      throw Exception(

        e.response?.data["detail"] ??
            "Google Login gagal",

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
      /// Logout Firebase
      await FirebaseAuth.instance.signOut();

      /// Logout Google
      final googleSignIn = GoogleSignIn();

      await googleSignIn.signOut();

      /// Putuskan akses agar account picker muncul lagi
      try {
        await googleSignIn.disconnect();
      } catch (_) {}

      /// Hapus JWT aplikasi
      await TokenStorage.clearToken();
    } catch (_) {
      await TokenStorage.clearToken();
    }
  }
}