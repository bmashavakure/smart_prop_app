// To parse this JSON data, do
//
//     final propertiesResponse = propertiesResponseFromJson(jsonString);

import 'dart:convert';

PropertiesResponse propertiesResponseFromJson(String str) =>
    PropertiesResponse.fromJson(json.decode(str));

String propertiesResponseToJson(PropertiesResponse data) =>
    json.encode(data.toJson());

class PropertiesResponse {
  String? status;
  String? message;
  Data? data;
  dynamic errors;

  PropertiesResponse({
    this.status,
    this.message,
    this.data,
    this.errors,
  });

  factory PropertiesResponse.fromJson(Map<String, dynamic> json) =>
      PropertiesResponse(
        status: json["status"] as String?,
        message: json["message"] as String?,
        data: json["data"] != null
            ? Data.fromJson(json["data"])
            : null,
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
  List<Property>? properties;

  Data({
    this.properties,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    properties: json["properties"] == null
        ? null
        : List<Property>.from(
      (json["properties"] as List)
          .map((x) => Property.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "properties":
    properties?.map((x) => x.toJson()).toList(),
  };
}

class Property {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? title;
  String? description;
  String? propertyType;
  String? address;
  String? city;
  int? price;
  String? currency;
  String? pricePeriod;
  int? bedrooms;
  int? bathrooms;
  int? areaSqft;
  List<String>? amenities;
  String? sourceWebsite;
  String? sourceUrl;
  String? externalId;
  String? imageUrls;
  DateTime? propertyCreatedAt;
  DateTime? propertyUpdatedAt;
  DateTime? lastScrapedAt;

  Property({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.title,
    this.description,
    this.propertyType,
    this.address,
    this.city,
    this.price,
    this.currency,
    this.pricePeriod,
    this.bedrooms,
    this.bathrooms,
    this.areaSqft,
    this.amenities,
    this.sourceWebsite,
    this.sourceUrl,
    this.externalId,
    this.imageUrls,
    this.propertyCreatedAt,
    this.propertyUpdatedAt,
    this.lastScrapedAt,
  });

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json["ID"] == null ? null : (json["ID"] is int ? json["ID"] : int.tryParse(json["ID"].toString())),
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    title: json["title"] as String?,
    description: json["description"] as String?,
    propertyType: json["property_type"] as String?,
    address: json["address"] as String?,
    city: json["city"] as String?,
    price: json["price"] == null ? null : (json["price"] is int ? json["price"] : int.tryParse(json["price"].toString())),
    currency: json["currency"] as String?,
    pricePeriod: json["price_period"] as String?,
    bedrooms: json["bedrooms"] == null ? null : (json["bedrooms"] is int ? json["bedrooms"] : int.tryParse(json["bedrooms"].toString())),
    bathrooms: json["bathrooms"] == null ? null : (json["bathrooms"] is int ? json["bathrooms"] : int.tryParse(json["bathrooms"].toString())),
    areaSqft: json["area_sqft"] == null ? null : (json["area_sqft"] is int ? json["area_sqft"] : int.tryParse(json["area_sqft"].toString())),
    amenities: json["amenities"] == null ? null : List<String>.from(json["amenities"].map((x) => x.toString())),
    sourceWebsite: json["source_website"] as String?,
    sourceUrl: json["source_url"] as String?,
    externalId: json["external_id"] as String?,
    imageUrls: json["image_urls"] as String?,
    propertyCreatedAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    propertyUpdatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    lastScrapedAt: json["last_scraped_at"] == null ? null : DateTime.parse(json["last_scraped_at"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "title": title,
    "description": description,
    "property_type": propertyType,
    "address": address,
    "city": city,
    "price": price,
    "currency": currency,
    "price_period": pricePeriod,
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "area_sqft": areaSqft,
    "amenities": amenities == null ? null : List<dynamic>.from(amenities!.map((x) => x)),
    "source_website": sourceWebsite,
    "source_url": sourceUrl,
    "external_id": externalId,
    "image_urls": imageUrls,
    "created_at": propertyCreatedAt?.toIso8601String(),
    "updated_at": propertyUpdatedAt?.toIso8601String(),
    "last_scraped_at": lastScrapedAt?.toIso8601String(),
  };
}




enum Currency { USD }

final currencyValues = EnumValues({
  "USD": Currency.USD,
});

enum PricePeriod { PER_MONTH }

final pricePeriodValues = EnumValues({
  "per month": PricePeriod.PER_MONTH,
});

enum PropertyType { RENTAL }

final propertyTypeValues = EnumValues({
  "RENTAL": PropertyType.RENTAL,
});

enum SourceWebsite { PROPERTYBOOK, PROPERTYCO, SEEFF }

final sourceWebsiteValues = EnumValues({
  "propertybook": SourceWebsite.PROPERTYBOOK,
  "propertyco": SourceWebsite.PROPERTYCO,
  "seeff": SourceWebsite.SEEFF,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap =
        map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
