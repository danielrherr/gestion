import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final bool service;
  AuthBloc(this.service) : super(AuthInitial());
  on<LoginEvent>((event,emit) async {
    emit(Loading());
    try{
      
    }
  });
}
