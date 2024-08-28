class StudentModel {
  List<Student> data;
  StudentModel({this.data = const []});

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List? ?? []; // Ensure 'data' is a List
    List<Student> data = dataList.map((e) => Student.fromMap(e)).toList();
    return StudentModel(data: data);
  }

  Map<String, dynamic> toMap() {
    return {"data": data.map((item) => item.toMap()).toList()};
  }
}

class Student {
  String id;
  String name;
  bool certified;
  int rollno;
  String password;
  int credit;
  String fcmtoken;
  String department;
  String token;
  String dp;
  String studentclass;
  String year;
  List<dynamic> followers;
  List<dynamic> following;
  String bio;
  Student(
      {this.id = "",
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
      this.followers = const [],
      this.following = const []});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'certified': certified,
      'rollno': rollno,
      'password': password,
      'credit': credit,
      'fcmtoken': fcmtoken,
      "department": department,
      'dp': dp,
      'year': year,
      'Studentclass': studentclass,
      'following': following,
      'followers': followers,
      "bio": bio,
      'token': token,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
        id: map['_id'] ?? '',
        name: map['name'] ?? '',
        certified: map['certified'] ?? false,
        rollno: map['rollno'] ?? 0,
        fcmtoken: map['fcmtoken'] ?? '',
        password: map['password'] ?? '',
        dp: map['dp'] ?? '',
        year: map['year'] ?? '',
        followers: List<String>.from(map['followers'] ?? []),
        following: List<String>.from(map['following'] ?? []),
        studentclass: map['Studentclass'] ?? '',
        department: map['department'] ?? '',
        credit: map['credit'] ?? 0,
        token: map['token'] ?? '',
        bio: map['bio'] ?? "");
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      certified: json['certified'] ?? false,
      rollno: json['rollno'] ?? 0,
      fcmtoken: json['fcmtoken'] ?? 'Null',
      password: json['password'] ?? '',
      dp: json['dp'] ?? '',
      year: json['year'] ?? '',
      followers: List<String>.from(json['followers'] ?? []),
      following: List<String>.from(json['following'] ?? []),
      studentclass: json['Studentclass'] ?? '',
      department: json['department'] ?? '',
      credit: json['credit'] ?? 0,
      bio: json['bio'] ?? '',
      token: json['token'] ?? '',
    );
  }
}
