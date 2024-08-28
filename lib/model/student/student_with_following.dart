class Following {
  final String id;
  final String name;
  final String dp;

  Following({
    this.id = '',
    this.name = '',
    this.dp = '',
  });

  factory Following.fromMap(Map<String, dynamic> map) {
    return Following(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      dp: map['dp'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'dp': dp,
    };
  }
}

class StudentWithFollowing {
  final String id;
  final String name;
  final bool certified;
  final int rollno;
  final String password;
  final int credit;
  final String fcmtoken;
  final String department;
  final String token;
  final String dp;
  final String studentclass;
  final String year;
  final List<Following> followers;
  final List<Following> following; // Changed to List<Following>
  final String bio;

  StudentWithFollowing({
    this.id = "",
    this.name = "",
    this.fcmtoken = "",
    this.certified = false,
    this.rollno = 0,
    this.password = "",
    this.department = "",
    this.credit = 0,
    this.token = "",
    this.dp = "",
    this.year = "",
    this.bio = "",
    this.studentclass = "",
    List<Following>? followers,
    List<Following>? following,
  })  : followers = followers ?? [],
        following = following ?? [];

  factory StudentWithFollowing.fromMap(Map<String, dynamic> map) {
    return StudentWithFollowing(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      certified: map['certified'] ?? false,
      rollno: map['rollno'] ?? 0,
      fcmtoken: map['fcmtoken'] ?? '',
      password: map['password'] ?? '',
      dp: map['dp'] ?? '',
      year: map['year'] ?? '',
      bio: map['bio'] ?? '',
      studentclass: map['Studentclass'] ?? '',
      department: map['department'] ?? '',
      credit: map['credit'] ?? 0,
      token: map['token'] ?? '',
      followers: (map['followers'] as List<dynamic>?)
          ?.map((item) => Following.fromMap(item as Map<String, dynamic>))
          .toList() ?? [],
      following: (map['following'] as List<dynamic>?)
          ?.map((item) => Following.fromMap(item as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'certified': certified,
      'rollno': rollno,
      'fcmtoken': fcmtoken,
      'password': password,
      'dp': dp,
      'year': year,
      'bio': bio,
      'Studentclass': studentclass,
      'department': department,
      'credit': credit,
      'token': token,
      'followers': followers.map((f) => f.toMap()).toList(),
      'following': following.map((f) => f.toMap()).toList(),
    };
  }
}
