import 'package:http/http.dart' as http;
import 'package:smart_prop_app/data/models/response_objects/auth_response.dart';
import 'package:smart_prop_app/core/constants/constants.dart';



class AuthProvider{
  //register func
  Future<AuthResponse> registerUserApiCall(String name, String email, String password) async{
    try{
      var url = Uri.parse("${Constants.apiBase}auth/register-user");
      final response = await http.post(
          url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: {
          'name': name,
          'email': email,
          'password':password
        }
      );

      if(response.statusCode == 200){
        return authResponseFromJson(response.body);
      }else{
        return authResponseFromJson(response.body);
      }

    }catch(e){
      throw Exception("Register User Failed");
    }
  }

  //login func
  Future<AuthResponse> loginUserApiCall(String email, String password) async{
    try{
      var url = Uri.parse("${Constants.apiBase}auth/login-user");
      final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: {
            'email': email,
            'password':password
          }
      );

      if(response.statusCode == 200){
        return authResponseFromJson(response.body);
      }else{
        return authResponseFromJson(response.body);
      }

    }catch(e){
      throw Exception("Register User Failed");
    }
  }
}