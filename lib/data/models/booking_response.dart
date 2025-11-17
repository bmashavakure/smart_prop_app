// To parse this JSON data, do
//
//     final bookingResponse = bookingResponseFromJson(jsonString);

import 'dart:convert';

BookingResponse bookingResponseFromJson(String str) =>
    BookingResponse.fromJson(json.decode(str));

String bookingResponseToJson(BookingResponse data) =>
    json.encode(data.toJson());

class BookingResponse {
  String? status;
  String? message;
  Data? data;
  Errors? errors;

  BookingResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        errors: json["errors"] != null ? Errors.fromJson(json["errors"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "errors": errors?.toJson(),
  };
}

class Data {
  int? bookingId;

  Data({
    required this.bookingId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookingId: json["booking_id"],
  );

  Map<String, dynamic> toJson() => {
    "booking_id": bookingId,
  };
}

class Errors {
  String? error;

  Errors({
    required this.error,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "error": error,
  };
}
