import 'package:dio/dio.dart';

import '../../core/constants/endpoint_constants.dart';
import '../../core/network/api_response.dart';
import '../../core/network/dio_client.dart';
import '../models/task/task_create_request.dart';
import '../models/task/task_model.dart';
import '../models/task/task_update_request.dart';

class TaskService {
  TaskService._();

  static final Dio _dio = DioClient.dio;

  /// GET /tasks/
  static Future<List<TaskModel>> getTasks() async {
    try {
      final response = await _dio.get(
        "${EndpointConstants.tasks}/",
      );

      final result =
          ApiResponse<List<TaskModel>>.fromJson(
        response.data,
        (json) => (json as List)
            .map((item) => TaskModel.fromJson(item))
            .toList(),
      );

      if (!result.success || result.data == null) {
        throw Exception(
          result.message ??
              "Gagal memuat daftar task",
        );
      }

      return result.data!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memuat daftar task",
      );
    }
  }

  /// GET /tasks/{task_id}
  static Future<TaskModel> getTask(
    String taskId,
  ) async {
    try {
      final response = await _dio.get(
        "${EndpointConstants.tasks}/$taskId",
      );

      final result =
          ApiResponse<TaskModel>.fromJson(
        response.data,
        (json) => TaskModel.fromJson(json),
      );

      if (!result.success || result.data == null) {
        throw Exception(
          result.message ??
              "Task tidak ditemukan",
        );
      }

      return result.data!;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Task tidak ditemukan",
      );
    }
  }

  /// POST /tasks/
  static Future<String> createTask(
    TaskCreateRequest request,
  ) async {
    try {
      final response = await _dio.post(
        "${EndpointConstants.tasks}/",
        data: request.toJson(),
      );

      final data =
          response.data as Map<String, dynamic>;

      if (data["success"] != true) {
        throw Exception(
          data["message"] ??
              "Gagal membuat task",
        );
      }

      return data["task_id"] as String;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal membuat task",
      );
    }
  }

  /// PUT /tasks/{task_id}
  static Future<void> updateTask(
    String taskId,
    TaskUpdateRequest request,
  ) async {
    try {
      final response = await _dio.put(
        "${EndpointConstants.tasks}/$taskId",
        data: request.toJson(),
      );

      final result =
          ApiResponse.fromJson(
        response.data,
        null,
      );

      if (!result.success) {
        throw Exception(
          result.message ??
              "Gagal memperbarui task",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal memperbarui task",
      );
    }
  }

  /// DELETE /tasks/{task_id}
  static Future<void> deleteTask(
    String taskId,
  ) async {
    try {
      final response = await _dio.delete(
        "${EndpointConstants.tasks}/$taskId",
      );

      final result =
          ApiResponse.fromJson(
        response.data,
        null,
      );

      if (!result.success) {
        throw Exception(
          result.message ??
              "Gagal menghapus task",
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["detail"] ??
            "Gagal menghapus task",
      );
    }
  }

  /// Convenience helper: marks a task as "Completed"
  static Future<void> markCompleted(
    String taskId,
  ) async {
    await updateTask(
      taskId,
      TaskUpdateRequest(status: "Completed"),
    );
  }

  /// Convenience helper: marks a task as "Pending"
  static Future<void> markPending(
    String taskId,
  ) async {
    await updateTask(
      taskId,
      TaskUpdateRequest(status: "Pending"),
    );
  }
}