class UserModel {
  final String token;
  final String id;
  final String name;
  final int rollno;
  final String password;
  final int credit;
  final String dp;
  final String department;
  final String studentClass;
  final String year;
  final bool certified;
  final String fcmToken;
  final List<String> followers;
  final List<String> following;
  final bool blocked;
  final String bio;

  UserModel({
    required this.token,
    required this.id,
    required this.name,
    required this.rollno,
    required this.password,
    required this.credit,
    required this.dp,
    required this.department,
    required this.studentClass,
    required this.year,
    required this.certified,
    required this.fcmToken,
    required this.followers,
    required this.following,
    required this.blocked,
    required this.bio,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      rollno: json['rollno'] ?? 0,
      password: json['password'] ?? '',
      credit: json['credit'] ?? 0,
      dp: json['dp'] ?? '',
      department: json['department'] ?? '',
      studentClass: json['Studentclass'] ?? '',
      year: json['year'] ?? '',
      certified: json['certified'] ?? false,
      fcmToken: json['fcmtoken'] ?? '',
      followers:
          json['followers'] != null ? List<String>.from(json['followers']) : [],
      following:
          json['following'] != null ? List<String>.from(json['following']) : [],
      blocked: json['blocked'] ?? false,
      bio: json['bio'] ?? '',
    );
  }
}
