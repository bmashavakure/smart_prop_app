import 'package:http/http.dart' as http;
import 'package:smart_prop_app/core/constants/constants.dart';
import 'package:smart_prop_app/data/models/preference_model.dart';
import 'package:smart_prop_app/data/models/response_objects/pref_response.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';


class PropertyProvider{
  
  //post user preferences
  Future<PreferenceResponse> userPreferencesApiCall(PreferenceModel reqObject, String token)async{
    try{
      var url = Uri.parse("${Constants.apiBase}user-preferences");

      final response = await http.post(
          url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${token}"
        },
        body: reqObject.toJson()
      );

      if(response.statusCode == 200){
        return preferenceResponseFromJson(response.body);
      }else{
        return preferenceResponseFromJson(response.body);
      }
      
    }catch(e){
      throw Exception(e.toString());
    }
    
  }
  
  
  //get properties
  Future<PropertiesResponse> getPropertiesApiCall(int userId, String token) async{
    try{
      var url = Uri.parse("${Constants.apiBase}user-preferences");

      final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer ${token}"
          },
          body: {
            'user_id': userId
          }
      );

      if(response.statusCode == 200){
        return propertiesResponseFromJson(response.body);
      }else{
        return propertiesResponseFromJson(response.body);
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }
}