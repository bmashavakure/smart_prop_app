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
  int? propertyId;
  String? title;
  String? description;
  PropertyType? propertyType;
  String? address;
  String? city;
  int? price;
  Currency? currency;
  PricePeriod? pricePeriod;
  int? bedrooms;
  int? bathrooms;
  double? areaSqft;
  List<String>? amenities;
  SourceWebsite? sourceWebsite;
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
    this.propertyId,
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
    id: json["ID"],
    createdAt: json["CreatedAt"] != null
        ? DateTime.tryParse(json["CreatedAt"])
        : null,
    updatedAt: json["UpdatedAt"] != null
        ? DateTime.tryParse(json["UpdatedAt"])
        : null,
    deletedAt: json["DeletedAt"],
    propertyId: json["id"],
    title: json["title"],
    description: json["description"],
    propertyType: json["property_type"] != null
        ? propertyTypeValues.map[json["property_type"]]
        : null,
    address: json["address"] as String?,
    city: json["city"] as String?,
    price: json["price"],
    currency: json["currency"] != null
        ? currencyValues.map[json["currency"]]
        : null,
    pricePeriod: json["price_period"] != null
        ? pricePeriodValues.map[json["price_period"]]
        : null,
    bedrooms: json["bedrooms"],
    bathrooms: json["bathrooms"],
    areaSqft: (json["area_sqft"] as num?)?.toDouble(),
    amenities: json["amenities"] == null
        ? null
        : List<String>.from(
        json["amenities"].map((x) => x.toString())),
    sourceWebsite: json["source_website"] != null
        ? sourceWebsiteValues.map[json["source_website"]]
        : null,
    sourceUrl: json["source_url"],
    externalId: json["external_id"],
    imageUrls: json["image_urls"],
    propertyCreatedAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    propertyUpdatedAt: json["updated_at"] != null
        ? DateTime.tryParse(json["updated_at"])
        : null,
    lastScrapedAt: json["last_scraped_at"] != null
        ? DateTime.tryParse(json["last_scraped_at"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "id": propertyId,
    "title": title,
    "description": description,
    "property_type": propertyTypeValues.reverse[propertyType],
    "address": address,
    "city": city,
    "price": price,
    "currency": currencyValues.reverse[currency],
    "price_period": pricePeriodValues.reverse[pricePeriod],
    "bedrooms": bedrooms,
    "bathrooms": bathrooms,
    "area_sqft": areaSqft,
    "amenities": amenities,
    "source_website":
    sourceWebsiteValues.reverse[sourceWebsite],
    "source_url": sourceUrl,
    "external_id": externalId,
    "image_urls": imageUrls,
    "created_at":
    propertyCreatedAt?.toIso8601String(),
    "updated_at":
    propertyUpdatedAt?.toIso8601String(),
    "last_scraped_at":
    lastScrapedAt?.toIso8601String(),
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
