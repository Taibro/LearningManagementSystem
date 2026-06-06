import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';
import 'dart:io' show Platform;

class DioClient {
  late final Dio dio;

  // Sử dụng localhost:8080 cho máy ảo, hoặc cấu hình adb reverse tcp:8080 tcp:8080 cho máy thật.
  // Nếu dùng Android Emulator không có reverse, IP sẽ là 10.0.2.2.
  static String get baseUrl {
    try {
      if (Platform.isAndroid) return 'http://10.0.2.2:8080/api';
      return 'http://localhost:8080/api';
    } catch (e) {
      // Dành cho Web
      return 'http://localhost:8080/api';
    }
  }

  DioClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Thêm Token vào Header nếu có
        final token = await SecureStorage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          // Xử lý token hết hạn (ví dụ: xoá token, đẩy ra màn hình login)
          await SecureStorage.deleteToken();
          // TODO: Gửi sự kiện đẩy về màn hình đăng nhập nếu cần
        }
        return handler.next(e);
      },
    ));
  }
}
