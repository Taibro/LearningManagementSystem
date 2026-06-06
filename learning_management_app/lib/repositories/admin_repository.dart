import 'package:dio/dio.dart';
import '../models/admin/admin_dashboard_stats.dart';

class AdminRepository {
  final Dio _dio;

  AdminRepository(this._dio);

  Future<AdminDashboardStats> getDashboardStats() async {
    try {
      final response = await _dio.get('/school-admin/dashboard/stats');
      return AdminDashboardStats.fromJson(response.data);
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return AdminDashboardStats(
          totalStudents: 0,
          totalTeachers: 0,
          totalClasses: 0,
          todayAbsences: 0,
          totalTuitionDebt: 0,
          schoolName: 'Hệ thống Quản lý Đào tạo',
        );
      }
      throw Exception('Lỗi khi tải thống kê tổng quan: $e');
    }
  }
}
