import 'package:smart_prop_app/data/provider/auth_provider.dart';
import 'package:smart_prop_app/core/utils/secure_storage_string.dart';


class AuthRepository{
  final authProvider = AuthProvider();
  final secureStorageInstance = SecureStorageStrings();
  //register user
  Future<String?> registerUser(String name, String email, String password) async{
    try{
      final response = await authProvider.registerUserApiCall(name, email, password);
      if(response.status == "success"){
        await secureStorageInstance.saveAuthToken(response.data?.token ?? "");
        await secureStorageInstance.saveUserId(response.data?.userId.toString() ?? "");

        return response. message;
      }else{
        throw Exception(response.message ?? "Registration failed");
      }

    }catch(e){
      throw Exception(e.toString());
    }
  }


  //login user
  Future<String?> loginUser(String email, String password) async{
    try{
      final response = await authProvider.loginUserApiCall(email, password);
      if(response.status == "success"){
        await secureStorageInstance.saveAuthToken(response.data?.token ?? "");
        await secureStorageInstance.saveUserId(response.data?.userId.toString() ?? "");

        return response.message;
      }else{
        throw Exception(response.message ?? "Login failed");
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }

  //logout user
  Future<void> logoutUser() async{
    try{
      await secureStorageInstance.clearAll();
    }catch(e){
      throw Exception(e.toString());
    }
  }

}