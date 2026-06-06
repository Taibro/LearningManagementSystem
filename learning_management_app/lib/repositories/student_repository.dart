import 'package:dio/dio.dart';
import '../core/network/dio_client.dart';
import '../models/student/student_profile.dart';
import '../models/student/student_schedule.dart';
import '../models/student/student_grade.dart';
import '../models/student/student_attendance.dart';

class StudentRepository {
  final DioClient _dioClient;

  StudentRepository(this._dioClient);

  Future<StudentProfile> getProfile() async {
    try {
      final response = await _dioClient.dio.get('/student/profile');
      return StudentProfile.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Lỗi khi lấy thông tin cá nhân: ${e.message}');
    }
  }

  Future<List<StudentSchedule>> getWeeklySchedule({String? date}) async {
    try {
      final queryParams = date != null ? {'date': date} : null;
      final response = await _dioClient.dio.get('/student/weekly-schedule', queryParameters: queryParams);
      return (response.data as List).map((e) => StudentSchedule.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Lỗi khi lấy lịch học: ${e.message}');
    }
  }

  Future<List<StudentGrade>> getGrades() async {
    try {
      final response = await _dioClient.dio.get('/student/grades');
      return (response.data as List).map((e) => StudentGrade.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Lỗi khi lấy kết quả học tập: ${e.message}');
    }
  }

  Future<List<StudentAttendance>> getAttendance() async {
    try {
      final response = await _dioClient.dio.get('/student/attendance');
      return (response.data as List).map((e) => StudentAttendance.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Lỗi khi lấy thông tin điểm danh: ${e.message}');
    }
  }
}
