import 'property_event.dart';
import 'property_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/data/models/preference_model.dart';
import 'package:smart_prop_app/data/repository/property_repository.dart';
import 'package:smart_prop_app/data/models/response_objects/property_response.dart';


class PropertyBloc extends Bloc<PropertyEvent, PropertyState>{
  final PropertyRepository propertyRepo;

  PropertyBloc({required this.propertyRepo}): super(PropertyInitial()){
    on<PreferenceSubmitEvent>(_onPreferenceSubmitEvent);
    on<LoadPropertyEvent>(_onPropertyLoadEvent);
  }


  //submit prefs
  Future<void> _onPreferenceSubmitEvent(PreferenceSubmitEvent event, Emitter<PropertyState> emit) async{
    emit(PropertyLoading());
    try{
      final response = await propertyRepo.userPreferencesFunc(event.reqObject);
      emit(PreferenceSubmitted(message: response!));
    }catch(e){
      emit(PropertyError(error: e.toString()));
    }

  }

  //load properties
  Future<void> _onPropertyLoadEvent(LoadPropertyEvent event, Emitter<PropertyState> emit) async{
    emit(PropertyLoading());
    try{
      final response = await propertyRepo.getUserPropertiesFunc();
      emit(PropertiesLoaded(properties: response?.$1, message: response?.$2));
    }catch(e){
      emit(PropertyError(error: e.toString()));
    }
  }

}