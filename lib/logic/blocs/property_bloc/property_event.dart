import 'package:equatable/equatable.dart';
import 'package:smart_prop_app/data/models/booking_model.dart';
import 'package:smart_prop_app/data/models/preference_model.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';

class PropertyEvent extends Equatable{
  const PropertyEvent();

  @override
  List<Object?> get props => [];
}


class PreferenceSubmitEvent extends PropertyEvent{
  final PreferenceModel reqObject;

  const PreferenceSubmitEvent({required this.reqObject});

  @override
  List<Object?> get props => [reqObject];
}


class LoadPropertyEvent extends PropertyEvent{}

class LoadBookingsEvent extends PropertyEvent{}


class BookingCreateEvent extends PropertyEvent{
  final BookingModel reqObject;

  const BookingCreateEvent({required this.reqObject});

  @override
  List<Object?> get props => [reqObject];
}


class BookingCancelEvent extends PropertyEvent{
  final int bookingID;

  const BookingCancelEvent({required this.bookingID});

  @override
  List<Object?> get props => [bookingID];
}
