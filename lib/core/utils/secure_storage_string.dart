import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStorageStrings{
  static AndroidOptions _getAndroidOptions = new AndroidOptions(encryptedSharedPreferences: true,);
  final storageInstance = FlutterSecureStorage(aOptions: SecureStorageStrings._getAndroidOptions);


  static String tokenKey = "auth_token";
  static String idKey = "user_id";

  saveAuthToken(String token) async{
    await storageInstance.write(key: tokenKey, value: token);
  }

  readAuthToken() async{
    String? authToken = await storageInstance.read(key: tokenKey);
    return authToken;
  }


  saveUserId(String userId) async{
    await storageInstance.write(key: idKey, value: userId);
  }

  readUserId() async{
    String? userId = await storageInstance.read(key: idKey);
    return userId;
  }
}