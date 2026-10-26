import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

/// Service untuk menyimpan token dan data sensitif secara terenkripsi
class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.keyAuthToken, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.keyAuthToken);
  }

  Future<void> saveUserRole(String role) async {
    await _storage.write(key: AppConstants.keyUserRole, value: role);
  }

  Future<String?> getUserRole() async {
    return await _storage.read(key: AppConstants.keyUserRole);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
