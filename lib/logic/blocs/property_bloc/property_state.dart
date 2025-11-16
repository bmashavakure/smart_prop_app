import 'package:equatable/equatable.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';


class PropertyState extends Equatable{
  PropertyState();

  @override
  List<Object?> get props => [];
}

class PropertyInitial extends PropertyState{}

class PropertyLoading extends PropertyState{}


class PreferenceSubmitted extends PropertyState{
  final String message;

  PreferenceSubmitted({required this.message});

  @override
  List<Object?> get props => [message];
}


class PropertiesLoaded extends PropertyState{
  final List<Property>? properties;
  final String? message;

  PropertiesLoaded({required this.properties, this.message});

  @override
  List<Object?> get props => [properties, message];
}


class PropertyError extends PropertyState{
  final String error;

  PropertyError({required this.error});

  @override
  List<Object?> get props => [error];
}

