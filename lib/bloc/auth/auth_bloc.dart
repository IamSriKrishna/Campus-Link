import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/auth/auth_event.dart';
import 'package:campuslink/bloc/auth/auth_state.dart';
import 'package:campuslink/controller/auth/auth_controller.dart';
import 'package:get_storage/get_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthController _controller;
  AuthBloc(this._controller) : super(InitialAuthState()) {
    on<LoginAuthEvent>((event, emit) async {
      emit(LoginAuthState(isLoading: true));
      try {
        emit(LoadingAuthState());
        final success = await _controller.login(
            registerNumber: event.registerNumber, password: event.password);
        await Future.delayed(const Duration(seconds: 5));
        if (success) {
          emit(SuccessAuthState());
        }
      } catch (e) {
        emit(FailedAuthState(error: e.toString()));
      }
    });

    on<GetStudentByIdEvent>((event, emit) async {
      emit(LoadingStudentState());
      try {
        final prefs = GetStorage();
        final userId = prefs.read("userId");
        if (userId == null) {
          throw Exception('User ID not found');
        }
        final student = await _controller.getStudentById(userId);
        emit(StudentLoadedState(student: student));
      } catch (e) {
        emit(StudentLoadFailedState(error: e.toString()));
      }
    });
  }
}
