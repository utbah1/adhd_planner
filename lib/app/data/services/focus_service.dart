import 'package:dio/dio.dart';

import '../../core/constants/endpoint_constants.dart';
import '../../core/network/api_response.dart';
import '../../core/network/dio_client.dart';

import '../models/focus/focus_plan_create_request.dart';
import '../models/focus/focus_plan_create_result.dart';
import '../models/focus/focus_plan_model.dart';
import '../models/focus/focus_plan_progress_model.dart';
import '../models/focus/focus_session_create_request.dart';
import '../models/focus/focus_session_model.dart';
import '../models/focus/focus_session_start_result.dart';

class FocusService {
  FocusService._();

  static final Dio _dio = DioClient.dio;

  /// POST /focus/plans
  /// NOTE: backend returns {success, plan_id, total_cycles, message} at
  /// the top level (no "data" wrapper), so we parse the raw map with
  /// FocusPlanCreateResult.fromJson instead of going through ApiResponse.
  static Future<FocusPlanCreateResult> createPlan(
    FocusPlanCreateRequest request,
  ) async {
    try {
      final response = await _dio.post(
        EndpointConstants.focusPlans,
        data: request.toJson(),
      );

      final data = response.data as Map<String, dynamic>;

      if (data["success"] != true) {
        throw Exception(
          data["message"] ?? "Gagal membuat focus plan",
        );
      }

      return FocusPlanCreateResult.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal membuat focus plan",
      );
    }
  }

  /// GET /focus/plans
  static Future<List<FocusPlanModel>> getPlans() async {
    try {
      final response = await _dio.get(
        EndpointConstants.focusPlans,
      );

      final result = ApiResponse<List<FocusPlanModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) => FocusPlanModel.fromJson(item))
            .toList(),
      );

      if (!result.success || result.data == null) {
        throw Exception(
          result.message ?? "Gagal memuat focus plan",
        );
      }

      return result.data!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memuat focus plan",
      );
    }
  }

  /// GET /focus/plans/{plan_id}
  static Future<FocusPlanModel> getPlan(String planId) async {
    try {
      final response = await _dio.get(
        "${EndpointConstants.focusPlans}/$planId",
      );

      final result = ApiResponse<FocusPlanModel>.fromJson(
        response.data,
        (json) => FocusPlanModel.fromJson(json),
      );

      if (!result.success || result.data == null) {
        throw Exception(
          result.message ?? "Focus plan tidak ditemukan",
        );
      }

      return result.data!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Focus plan tidak ditemukan",
      );
    }
  }

  /// GET /focus/plans/{plan_id}/progress
  /// NOTE: same top-level shape as createPlan — {success, completed_cycles,
  /// total_cycles, progress, status} with no "data" key.
  static Future<FocusPlanProgressModel> getProgress(
    String planId,
  ) async {
    try {
      final response = await _dio.get(
        "${EndpointConstants.focusPlans}/$planId/progress",
      );

      final data = response.data as Map<String, dynamic>;

      if (data["success"] != true) {
        throw Exception(
          data["message"] ?? "Gagal memuat progress",
        );
      }

      return FocusPlanProgressModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memuat progress",
      );
    }
  }

  /// POST /focus/plans/{plan_id}/sessions
  /// NOTE: also top-level {success, session_id, message}, no "data" key.
  static Future<FocusSessionStartResult> startSession(
    String planId,
    FocusSessionCreateRequest request,
  ) async {
    try {
      final response = await _dio.post(
        "${EndpointConstants.focusPlans}/$planId/sessions",
        data: request.toJson(),
      );

      final data = response.data as Map<String, dynamic>;

      if (data["success"] != true) {
        throw Exception(
          data["message"] ?? "Gagal memulai session",
        );
      }

      return FocusSessionStartResult.fromJson(data);
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memulai session",
      );
    }
  }

  /// POST /focus/sessions/{session_id}/complete
  static Future<void> completeSession(String sessionId) async {
    try {
      final response = await _dio.post(
        "${EndpointConstants.focusSessions}/$sessionId/complete",
      );

      final result = ApiResponse.fromJson(
        response.data,
        null,
      );

      if (!result.success) {
        throw Exception(
          result.message ?? "Gagal menyelesaikan session",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal menyelesaikan session",
      );
    }
  }

  /// GET /focus/history
  static Future<List<FocusSessionModel>> getHistory() async {
    try {
      final response = await _dio.get(
        EndpointConstants.focusHistory,
      );

      final result = ApiResponse<List<FocusSessionModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) => FocusSessionModel.fromJson(item))
            .toList(),
      );

      if (!result.success || result.data == null) {
        throw Exception(
          result.message ?? "Gagal memuat riwayat focus session",
        );
      }

      return result.data!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memuat riwayat focus session",
      );
    }
  }
}