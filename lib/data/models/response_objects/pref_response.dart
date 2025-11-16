// To parse this JSON data, do
//
//     final preferenceResponse = preferenceResponseFromJson(jsonString);

import 'dart:convert';

PreferenceResponse preferenceResponseFromJson(String str) =>
    PreferenceResponse.fromJson(json.decode(str));

String preferenceResponseToJson(PreferenceResponse data) =>
    json.encode(data.toJson());

class PreferenceResponse {
  String? status;
  String? message;
  dynamic data;
  dynamic errors;

  PreferenceResponse({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory PreferenceResponse.fromJson(Map<String, dynamic> json) =>
      PreferenceResponse(
        status: json["status"] as String?,
        message: json["message"] as String?,
        data: json["data"],
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data,
    "errors": errors,
  };
}
