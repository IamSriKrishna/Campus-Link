class ReadAuthState {
  final int registerNumber;
  final String password;
  ReadAuthState({this.registerNumber = 0, this.password = ''});

  ReadAuthState copyWith({
    int? registerNumber,
    String? password,
  }) {
    return ReadAuthState(
      registerNumber: registerNumber ?? this.registerNumber,
      password: password ?? this.password,
    );
  }
}
