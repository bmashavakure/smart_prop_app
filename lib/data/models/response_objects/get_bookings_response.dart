// To parse this JSON data, do
//
//     final getBookingsResponse = getBookingsResponseFromJson(jsonString);

import 'dart:convert';
import 'property_response.dart';

GetBookingsResponse getBookingsResponseFromJson(String str) =>
    GetBookingsResponse.fromJson(json.decode(str));

String getBookingsResponseToJson(GetBookingsResponse data) =>
    json.encode(data.toJson());

class GetBookingsResponse {
  String? status;
  String? message;
  Data? data;
  dynamic errors;

  GetBookingsResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.errors,
  });

  factory GetBookingsResponse.fromJson(Map<String, dynamic> json) =>
      GetBookingsResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        errors: json["errors"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "errors": errors,
  };
}

class Data {
  List<Booking>? bookings;
  int? count;

  Data({
    required this.bookings,
    required this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookings: json["bookings"] != null
        ? List<Booking>.from(
        json["bookings"].map((x) => Booking.fromJson(x)))
        : null,
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "bookings":
    bookings != null ? List<dynamic>.from(bookings!.map((x) => x.toJson())) : null,
    "count": count,
  };
}

class Booking {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? propertyId;
  DateTime? bookingDate;
  String? bookingTime;
  DateTime? checkoutDate;
  String? checkoutTime;
  int? userId;
  User? user;
  Property? property;

  Booking({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.propertyId,
    required this.bookingDate,
    required this.bookingTime,
    required this.checkoutDate,
    required this.checkoutTime,
    required this.userId,
    required this.user,
    required this.property,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["ID"],
    createdAt:
    json["CreatedAt"] != null ? DateTime.parse(json["CreatedAt"]) : null,
    updatedAt:
    json["UpdatedAt"] != null ? DateTime.parse(json["UpdatedAt"]) : null,
    deletedAt: json["DeletedAt"],
    propertyId: json["property_id"],
    bookingDate: json["booking_date"] != null
        ? DateTime.parse(json["booking_date"])
        : null,
    bookingTime: json["booking_time"],
    checkoutDate: json["checkout_date"] != null
        ? DateTime.parse(json["checkout_date"])
        : null,
    checkoutTime: json["checkout_time"],
    userId: json["user_id"],
    user: json["User"] != null ? User.fromJson(json["User"]) : null,
    property:
    json["Property"] != null ? Property.fromJson(json["Property"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "property_id": propertyId,
    "booking_date": bookingDate != null
        ? "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}"
        : null,
    "booking_time": bookingTime,
    "checkout_date": checkoutDate != null
        ? "${checkoutDate!.year.toString().padLeft(4, '0')}-${checkoutDate!.month.toString().padLeft(2, '0')}-${checkoutDate!.day.toString().padLeft(2, '0')}"
        : null,
    "checkout_time": checkoutTime,
    "user_id": userId,
    "User": user?.toJson(),
    "Property": property?.toJson(),
  };
}


class User {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? name;
  String? email;
  String? password;

  User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.name,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["ID"],
    createdAt:
    json["CreatedAt"] != null ? DateTime.parse(json["CreatedAt"]) : null,
    updatedAt:
    json["UpdatedAt"] != null ? DateTime.parse(json["UpdatedAt"]) : null,
    deletedAt: json["DeletedAt"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "name": name,
    "email": email,
    "password": password,
  };
}
