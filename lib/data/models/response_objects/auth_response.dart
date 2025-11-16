// To parse this JSON data, do
//
//     final authResponse = authResponseFromJson(jsonString);

import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  String? status;
  String? message;
  Data? data;
  Errors? errors;

  AuthResponse({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
    status: json["status"] as String?,
    message: json["message"] as String?,
    data: json["data"] != null
        ? Data.fromJson(json["data"] as Map<String, dynamic>)
        : null,
    errors: json["errors"] != null
        ? Errors.fromJson(json["errors"] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "errors": errors?.toJson(),
  };
}

class Data {
  String? token;
  int? userId;

  Data({
    this.token,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"] as String?,
    userId: json["user_id"] is int
        ? json["user_id"] as int
        : (json["user_id"] != null
        ? int.tryParse(json["user_id"].toString())
        : null),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user_id": userId,
  };
}

class Errors {
  String? error;

  Errors({
    this.error,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    error: json["error"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
