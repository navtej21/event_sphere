import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage{

  static const _storage=FlutterSecureStorage();
  static const _jwt='jwt_token';


  static Future<void> storeToken(String token) async{
    await _storage.write(key:_jwt,value:token);
  }

  static Future<String?> getToken() async{
    return await _storage.read(key: _jwt);
  }

  static Future<void> deleteToken() async{
    await _storage.delete(key:_jwt);
  }

  
}