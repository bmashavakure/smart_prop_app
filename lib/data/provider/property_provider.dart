import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_prop_app/core/constants/constants.dart';
import 'package:smart_prop_app/data/models/booking_model.dart';
import 'package:smart_prop_app/data/models/booking_response.dart';
import 'package:smart_prop_app/data/models/preference_model.dart';
import 'package:smart_prop_app/data/models/response_objects/get_bookings_response.dart';
import 'package:smart_prop_app/data/models/response_objects/pref_response.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';


class PropertyProvider{
  
  //post user preferences
  Future<PreferenceResponse> userPreferencesApiCall(PreferenceModel reqObject, String token)async{
    try{
      var url = Uri.parse("${Constants.apiBase}prop/user-preferences");
      
      String jsonBody = jsonEncode(reqObject.toJson());

      final response = await http.post(
          url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonBody
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
      var url = Uri.parse("${Constants.apiBase}prop/get-properties");

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


  //make a booking api call
  Future<BookingResponse> createBookingApiCall(BookingModel model, String token) async{
    try{
      var url = Uri.parse("${Constants.apiBase}prop/create-booking");

      String jsonBody = jsonEncode(model.toJson());

      final response = await http.post(
          url,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: jsonBody
      );

      if(response.statusCode == 200){
        return bookingResponseFromJson(response.body);
      }else{
        return bookingResponseFromJson(response.body);
      }

    }catch(e){
      throw Exception(e.toString());
    }
  }

  //get bookings api call
  Future<GetBookingsResponse> getBookingsApiCall(int userID, String token) async{
    try{
      var url = Uri.parse("${Constants.apiBase}prop/get-bookings");

      final response = await http.post(
          url,
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer ${token}"
          },
          body: {
            'user_id': userID
          }
      );

      if(response.statusCode == 200){
        return getBookingsResponseFromJson(response.body);
      }else{
        return getBookingsResponseFromJson(response.body);
      }

    }catch(e){
      throw Exception(e.toString());
    }
  }
}