abstract class ReadAuthEvent {}

class RegisterNumberReadAuthEvent extends ReadAuthEvent {
  final int registerNumber;
  RegisterNumberReadAuthEvent({required this.registerNumber});
}

class PasswordReadAuthEvent extends ReadAuthEvent {
  final String password;
  PasswordReadAuthEvent({required this.password});
}
