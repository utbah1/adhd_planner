import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/constants/endpoint_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/user_model.dart';

class ProfileService {
  ProfileService._();

  static Future<UserModel> getProfile() async {
    try {
      final response = await DioClient.dio.get(
        EndpointConstants.profile,
      );

      return UserModel.fromJson(
        response.data["data"],
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ?? "Gagal memuat profil",
      );
    }
  }

  /// Upload foto dari file lokal ke backend → Firebase Storage
  /// Returns download URL foto yang sudah diupload
  static Future<String> uploadPhoto(File imageFile) async {
    try {
      final fileName = imageFile.path.split('/').last;
      final mimeType = _mimeTypeFromExtension(fileName);

      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
          contentType: DioMediaType.parse(mimeType),
        ),
      });

      /// Kirim dengan Content-Type: multipart/form-data
      final response = await DioClient.dio.post(
        EndpointConstants.uploadPhoto,
        data: formData,
        options: Options(
          contentType: "multipart/form-data",
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      return response.data["photo_url"] as String;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ?? "Gagal upload foto",
      );
    }
  }

  static Future<UserModel> updateProfile({
    String? fullname,
    String? photoUrl,
  }) async {
    try {
      final response = await DioClient.dio.put(
        EndpointConstants.profile,
        data: {
          if (fullname != null) "fullname": fullname,
          if (photoUrl != null) "photo_url": photoUrl,
        },
      );

      return UserModel.fromJson(
        response.data["data"],
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ?? "Gagal update profil",
      );
    }
  }

  static Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await DioClient.dio.post(
        EndpointConstants.changePassword,
        data: {
          "current_password": currentPassword,
          "new_password": newPassword,
        },
      );
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ?? "Gagal mengubah password",
      );
    }
  }

  static String _mimeTypeFromExtension(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      default:
        return 'image/jpeg';
    }
  }
}
