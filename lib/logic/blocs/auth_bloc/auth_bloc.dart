import 'auth_event.dart';
import 'auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_prop_app/data/repository/auth_repository.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository authRepo;

  AuthBloc({required this.authRepo}): super(AuthInitial()){
    on<AuthRegisterEvent>(_onAuthRegister);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthLogoutEvent>(_onAuthLogout);
  }


  //register
  Future<void> _onAuthRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    try{
      final response = await authRepo.registerUser(event.name, event.email, event.password);
      emit(AuthAuthenticated(message: response!));
    }catch(e){
      emit(AuthError(error: e.toString()));
    }
  }

  //login
  Future<void> _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit)async{
    emit(AuthLoading());
    try{
      final response = await authRepo.loginUser(event.email, event.password);
      emit(AuthAuthenticated(message: response!));
    }catch(e){
      emit(AuthError(error: e.toString()));
    }
  }


  //logout
  Future<void> _onAuthLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async{

  }

}