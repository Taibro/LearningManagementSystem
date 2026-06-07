import 'package:dio/dio.dart';
import '../models/admin/dashboard_stats.dart';
import '../models/admin/schedule_exception_response.dart';
import '../models/admin/notification_response.dart';

class SchoolAdminRepository {
  final Dio _dio;

  SchoolAdminRepository(this._dio);

  Future<DashboardStats> getDashboardStats() async {
    try {
      final response = await _dio.get('/school-admin/dashboard/stats');
      return DashboardStats.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi tải thống kê: $e');
    }
  }

  Future<List<ScheduleExceptionResponse>> getPendingExceptions() async {
    try {
      final response = await _dio.get('/school-admin/schedule-exceptions/pending');
      final data = response.data as List;
      return data.map((e) => ScheduleExceptionResponse.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Lỗi khi tải danh sách yêu cầu: $e');
    }
  }

  Future<ScheduleExceptionResponse> approveException(int id) async {
    try {
      final response = await _dio.put('/school-admin/schedule-exceptions/$id/approve');
      return ScheduleExceptionResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi duyệt yêu cầu: $e');
    }
  }

  Future<ScheduleExceptionResponse> rejectException(int id, String adminNote) async {
    try {
      final response = await _dio.put('/school-admin/schedule-exceptions/$id/reject', data: {'adminNote': adminNote});
      return ScheduleExceptionResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi từ chối yêu cầu: $e');
    }
  }

  Future<List<NotificationResponse>> getAllNotifications() async {
    try {
      final response = await _dio.get('/school-admin/notifications');
      final data = response.data as List;
      return data.map((e) => NotificationResponse.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Lỗi khi tải danh sách thông báo: $e');
    }
  }

  Future<NotificationResponse> createNotification(Map<String, dynamic> request) async {
    try {
      final response = await _dio.post('/school-admin/notifications', data: request);
      return NotificationResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi tạo thông báo: $e');
    }
  }

  Future<Map<String, dynamic>> createStudent(Map<String, dynamic> request) async {
    try {
      final response = await _dio.post('/school-admin/students', data: request);
      return response.data;
    } catch (e) {
      throw Exception('Lỗi khi tạo sinh viên: $e');
    }
  }

  Future<Map<String, dynamic>> createTeacher(Map<String, dynamic> request) async {
    try {
      final response = await _dio.post('/school-admin/teachers', data: request);
      return response.data;
    } catch (e) {
      throw Exception('Lỗi khi tạo giảng viên: $e');
    }
  }
}
