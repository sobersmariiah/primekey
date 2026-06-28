import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // Generic Write
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Generic Read
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  // Generic Delete
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  // Specific helpers for common security tasks
  Future<void> saveSensitiveUserData(String jsonUserData) async {
    await write('sensitive_user_data', jsonUserData);
  }

  Future<String?> getSensitiveUserData() async {
    return await read('sensitive_user_data');
  }
}
