import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyUserName = 'username';
  final String _keyUserPhone = 'phone';
  final String _keyUserToken = 'token';
  final String _keyUserEmail = 'email';
  final String _keyPassWord = 'password';

  Future deleteAll() async {
    await storage.deleteAll();
  }
  Future delete(String value) async {
    await storage.delete(key: value);
  }
  Future setUserName(String username) async {
    await storage.write(key: _keyUserName, value: username);
  }
  Future setUserToken(String userToken) async {
    await storage.write(key: _keyUserToken, value: userToken);
  }
  Future setUserPhone(String userPhone) async {
    await storage.write(key: _keyUserPhone, value: userPhone);
  }
  Future setUserEmail(String userEmail) async {
    await storage.write(key: _keyUserEmail, value: userEmail);
  }

  Future<String?> getUserToken() async {
    return await storage.read(key: _keyUserToken);
  }
  Future<String?> getUserEmail() async {
    return await storage.read(key: _keyUserEmail);
  }
  Future<String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }
  Future<String?> getUserPhone() async {
    return await storage.read(key: _keyUserPhone);
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }
  
// // Delete value
// await storage.delete(key: key);

// // Delete all
// await storage.deleteAll();
}
