// auth_state.dart

import 'package:campuslink/model/student/student.dart';

abstract class AuthState {}

class InitialAuthState extends AuthState {}

class LoginAuthState extends AuthState {
  final bool isLoading;
  LoginAuthState({required this.isLoading});
}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {}

class FailedAuthState extends AuthState {
  final String error;
  FailedAuthState({required this.error});
}

class LoadingStudentState extends AuthState {}

class StudentLoadedState extends AuthState {
  final Student student;
  StudentLoadedState({required this.student});
}

class StudentLoadFailedState extends AuthState {
  final String error;
  StudentLoadFailedState({required this.error});
}
