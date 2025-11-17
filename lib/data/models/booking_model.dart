class BookingModel{
  int? userID;
  int? propertyID;
  String? bookingDate;
  String? bookingTime;
  String? checkoutDate;
  String? checkoutTime;


  BookingModel({
    required this.userID,
    required this.propertyID,
    required this.bookingDate,
    required this.bookingTime,
    required this.checkoutDate,
    required this.checkoutTime
});


  factory BookingModel.fromJson(Map<String, dynamic> json){
    return BookingModel(
        userID: json['user_id'] as int?,
        propertyID: json['property_id'] as int?,
        bookingDate: json['booking_date'] as String?,
        bookingTime: json['booking_time'] as String?,
        checkoutDate: json['checkout_date'] as String?,
        checkoutTime: json['checkout_time'] as String?,
    );
  }


  Map<String, dynamic> toJson(){
    return {
      'user_id': userID,
      'property_id': propertyID,
      'booking_date': bookingDate,
      'booking_time': bookingTime,
      'checkout_date': checkoutDate,
      'checkout_time': checkoutTime
    };
  }


}