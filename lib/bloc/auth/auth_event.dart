abstract class AuthEvent {}

class LoginAuthEvent extends AuthEvent {
  final int registerNumber;
  final String password;
  LoginAuthEvent({required this.password, required this.registerNumber});
}

class GetStudentByIdEvent extends AuthEvent {
}