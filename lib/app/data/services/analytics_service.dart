import 'package:dio/dio.dart';

import '../../core/constants/endpoint_constants.dart';
import '../../core/network/api_response.dart';
import '../../core/network/dio_client.dart';

import '../models/analytics/analytics_dashboard_model.dart';
import '../models/analytics/weekly_analytics_model.dart';

class AnalyticsService {
  AnalyticsService._();

  static final Dio _dio = DioClient.dio;

  /// GET /analytics/dashboard?date=today
  static Future<AnalyticsDashboardModel> getDashboardForToday() async {
    try {
      final response = await _dio.get(
        EndpointConstants.dashboard,
        queryParameters: {
          "date": "today",
        },
      );


      final result = ApiResponse<AnalyticsDashboardModel>.fromJson(
        response.data,
        (json) => AnalyticsDashboardModel.fromJson(json),
      );

      if (!result.success || result.data == null) {
        throw Exception(
          result.message ?? "Gagal memuat analytics dashboard",
        );
      }

      return result.data!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memuat analytics dashboard",
      );
    }
  }

  /// GET /analytics/weekly
  static Future<WeeklyAnalyticsModel> getWeekly() async {
    try {
      final response = await _dio.get(
        EndpointConstants.weekly,
      );

      final result = ApiResponse<WeeklyAnalyticsModel>.fromJson(
        response.data,
        (json) => WeeklyAnalyticsModel.fromJson(json),
      );

      if (!result.success || result.data == null) {
        throw Exception(
          result.message ?? "Gagal memuat analytics mingguan",
        );
      }

      return result.data!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memuat analytics mingguan",
      );
    }
  }
}