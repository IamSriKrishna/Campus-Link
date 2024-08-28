class Auth {
  final int registerNumber;
  final String password;
  Auth({
    this.registerNumber = 0,
    this.password = '',
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      registerNumber: json['rollno'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"rollno": registerNumber, "password": password};
  }
}
