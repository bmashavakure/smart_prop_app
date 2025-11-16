class PreferenceModel{
 final int? userID;
 final String? budget;
 final int? bedrooms;
 final double? propertySize;
 final List<String>? locations;
 final List<String>? amenities;

 PreferenceModel({
   required this.userID,
   required this.budget,
   required this.bedrooms,
   required this.propertySize,
   required this.locations,
   required this.amenities,});

 factory PreferenceModel.fromJson(Map<String, dynamic> json){
   return PreferenceModel(
       userID: json['user_id'] as int?,
       budget: json['budget'] as String?,
       bedrooms: json['bedrooms'] as int?,
       propertySize: json['property_size'] as double?,
       locations:(json['locations'] as List<dynamic>?)
           ?.map((e) => e.toString())
           .toList(),
       amenities: (json['amenities'] as List<dynamic>?)
           ?.map((e) => e.toString())
           .toList(),
   );
 }

 Map<String, dynamic> toJson(){
   return {
     'user_id': userID,
     'budget': budget,
     'bedrooms': bedrooms,
     'property_size': propertySize,
     'locations': locations,
     'amenities': amenities
   };
 }
}