import 'package:smart_prop_app/data/provider/property_provider.dart';
import 'package:smart_prop_app/core/utils/secure_storage_string.dart';
import 'package:smart_prop_app/data/models/preference_model.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';


class PropertyRepository{
  final propertyProvider = PropertyProvider();
  final secureStorageInstance = SecureStorageStrings();

  //post user preferences
  Future<String?> userPreferencesFunc(PreferenceModel reqObject) async{
    try{
      String token = await secureStorageInstance.readAuthToken();
      final response = await propertyProvider.userPreferencesApiCall(reqObject, token);
      if(response.status == "success"){
        return response.message;
      }else{
        return response.message;
      }
    }catch(e){
      return "Failed to send user preferences";
    }
  }

  //get user properties
  Future<(List<Property>?, String?)?> getUserPropertiesFunc() async{
    try{
      List<Property>? properties = [];
      String token = await secureStorageInstance.readAuthToken();
      String userID = await secureStorageInstance.readUserId();
      final response = await propertyProvider.getPropertiesApiCall(int.tryParse(userID) ?? 1, token);
      if(response.status == "success"){
        properties = response.data?.properties;
        return (properties, response.message);
      }else{
        return (properties, response.message);
      }
    }catch(e){
      return (null, e.toString());
    }
  }
}