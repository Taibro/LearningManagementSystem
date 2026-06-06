import 'package:dio/dio.dart';
import '../models/lecturer/teacher_profile.dart';
import '../models/lecturer/monthly_salary.dart';
import '../models/lecturer/teaching_statistic.dart';
import '../models/lecturer/teacher_attendance.dart';
import '../models/lecturer/teacher_material.dart';

class TeacherRepository {
  final Dio _dio;

  TeacherRepository(this._dio);

  Future<TeacherProfile> getProfile() async {
    try {
      final response = await _dio.get('/api/lecturer/profile');
      return TeacherProfile.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi tải thông tin giảng viên: $e');
    }
  }

  Future<MonthlySalary> getMonthlySalary(int year, int month) async {
    try {
      final response = await _dio.get(
        '/api/lecturer/salaries/monthly',
        queryParameters: {'year': year, 'month': month},
      );
      return MonthlySalary.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi tải bảng lương: $e');
    }
  }

  Future<TeachingStatistic> getDashboardStatistics() async {
    try {
      final response = await _dio.get('/api/lecturer/statistics/dashboard');
      return TeachingStatistic.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi tải thống kê giảng dạy: $e');
    }
  }

  Future<List<TeacherMaterial>> getMaterials(int teacherId) async {
    try {
      final response = await _dio.get(
        '/api/lecturer/materials',
        queryParameters: {'teacherId': teacherId},
      );
      
      final List<dynamic> data = response.data;
      return data.map((m) => TeacherMaterial.fromJson(m)).toList();
    } catch (e) {
      throw Exception('Lỗi khi tải tài liệu bài giảng: $e');
    }
  }

  Future<TeacherAttendanceList> getAttendanceList(
      int classId, int scheduleId, String date) async {
    try {
      final response = await _dio.get(
        '/api/lecturer/attendance',
        queryParameters: {
          'classId': classId,
          'scheduleId': scheduleId,
          'date': date,
        },
      );
      return TeacherAttendanceList.fromJson(response.data);
    } catch (e) {
      throw Exception('Lỗi khi tải danh sách sinh viên: $e');
    }
  }

  Future<void> saveAttendance(Map<String, dynamic> request) async {
    try {
      await _dio.post('/api/lecturer/attendance/save', data: request);
    } catch (e) {
      throw Exception('Lỗi khi lưu điểm danh: $e');
    }
  }
}
