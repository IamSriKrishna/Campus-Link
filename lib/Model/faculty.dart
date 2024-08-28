import 'dart:convert';

class faculty {
  final String id;
  final String name;
  final String email;
  final String password;
  final String department;
  final String token;
  final String dp;
  final String classTeacher;
  final String role;
  final String fcmtoken;
  faculty({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.department,
    required this.token,
    required this.dp,
    required this.role,
    required this.fcmtoken,
    required this.classTeacher
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'fcmtoken':fcmtoken,
      'password': password,
      "department":department,
      'dp':dp,
      'role':role,
      'classTeacher':classTeacher,
      'token': token,
    };
  }

  factory faculty.fromMap(Map<String, dynamic> map) {
    return faculty(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      dp:map["dp"]??'',
      role:map['role']??'',
      fcmtoken: map['fcmtoken']??'',
      classTeacher:map['classTeacher']??'',
      department:map['department']?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory faculty.fromJson(String source) => faculty.fromMap(json.decode(source));

  faculty copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? department,
    String? dp,
    String? fcmtoken,
    String? classTeacher,
    String? role,
    int? credit,
    String? token,
  }) {
    return faculty(
      id: id ?? this.id,
      name: name ?? this.name,
      dp:dp?? this.dp,
      fcmtoken:fcmtoken??this.fcmtoken,
      role:role??this.role,
      classTeacher:classTeacher??this.classTeacher,
      department: department??this.department,
      email: email ?? this.email,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}