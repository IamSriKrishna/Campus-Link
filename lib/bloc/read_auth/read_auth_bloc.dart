import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/read_auth/read_auth_event.dart';
import 'package:campuslink/bloc/read_auth/read_auth_state.dart';

class ReadAuthBloc extends Bloc<ReadAuthEvent, ReadAuthState> {
  ReadAuthBloc() : super(ReadAuthState()) {
    on<RegisterNumberReadAuthEvent>((event, emit) {
      emit(state.copyWith(registerNumber: event.registerNumber));
    });
    on<PasswordReadAuthEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });
  }
}
