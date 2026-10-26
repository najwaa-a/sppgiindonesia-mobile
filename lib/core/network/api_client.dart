import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../storage/secure_storage_service.dart';
import 'auth_interceptor.dart';

/// Client HTTP Dio terpusat dengan base URL dari .env
class ApiClient {
  late final Dio dio;
  final SecureStorageService storageService;

  ApiClient({SecureStorageService? storage})
      : storageService = storage ?? SecureStorageService() {
    final supabaseUrl = dotenv.env['SUPABASE_URL'];
    final anonKey = dotenv.env['SUPABASE_ANON_KEY'];
    final baseUrl = supabaseUrl != null && supabaseUrl.isNotEmpty
        ? '$supabaseUrl/rest/v1'
        : (dotenv.env['API_BASE_URL'] ?? 'https://sppgindonesia.com/api');

    final headers = <String, dynamic>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (anonKey != null && anonKey.isNotEmpty) {
      headers['apikey'] = anonKey;
    }

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: headers,
      ),
    );

    dio.interceptors.add(AuthInterceptor(storageService));
  }
}
