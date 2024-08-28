import 'dart:convert'; // Import the dart:convert library

class FormModel {
  final String id;
  final String studentid;
  final String name;
  final String rollno;
  final String department;
  final String dp;
  final String formtype;
  final String year;
  final String Studentclass;
  final String reason;
  final int no_of_days;
  final String from;
  final String response;
  final int spent;
  final String fcmtoken;
  final String to;
  final DateTime createdAt; // Add the createdAt field

  FormModel({
    required this.id,
    required this.studentid,
    required this.name,
    required this.rollno,
    required this.department,
    required this.dp,
    required this.year,
    required this.fcmtoken,
    required this.response,
    required this.formtype,
    required this.no_of_days,
    required this.Studentclass,
    required this.spent,
    required this.reason,
    required this.from,
    required this.to,
    required this.createdAt, // Include createdAt in the constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentid': studentid,
      'name': name,
      'rollno': rollno,
      'department': department,
      'dp': dp,
      'response': response,
      'spent':spent,
      'fcmtoken':fcmtoken,
      'formtype': formtype,
      'year': year,
      'no_of_days': no_of_days,
      'Studentclass': Studentclass,
      'reason': reason,
      'from': from,
      'to': to,
      'createdAt': createdAt.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }

  factory FormModel.fromMap(Map<String, dynamic> map) {
    return FormModel(
      id: map['_id'] ?? '',
      studentid: map['studentid']?? '',
      name: map['name'] ?? '',
      rollno: map['rollno'] ?? '',
      dp: map["dp"] ?? '',
      response: map['response'] ?? '',
      fcmtoken:map['fcmtoken'] ?? '',
      spent:map['spent'] ?? 0,
      no_of_days: map['no_of_days'] ?? 0,
      reason: map['reason'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      year: map['year'] ?? '',
      Studentclass: map['Studentclass'] ?? '',
      formtype: map['formtype'] ?? '',
      department: map['department'] ?? '',
      createdAt: DateTime.parse(map['createdAt']), // Parse ISO 8601 string to DateTime
    );
  }

  String toJson() => json.encode(toMap());

  factory FormModel.fromJson(String source) => FormModel.fromMap(json.decode(source));

  FormModel copyWith({
    String? id,
    String? studentid,
    String? name,
    String? rollno,
    String? department,
    String? dp,
    String? response,
    int? no_of_days,
    String? reason,
    String? from,
    String? to,
    String? Studentclass,
    String? fcmtoken,
    String? formtype,
    String? year,
    int? spent,
    DateTime? createdAt, // Include createdAt in copyWith
  }) {
    return FormModel(
      id: id ?? this.id,
      studentid: studentid ?? this.studentid,
      name: name ?? this.name,
      dp: dp ?? this.dp,
      spent:spent??this.spent,
      no_of_days: no_of_days ?? this.no_of_days,
      year: year ?? this.year,
      formtype: formtype ?? this.formtype,
      from: from ?? this.from,
      fcmtoken:fcmtoken??this.fcmtoken,
      response: response ?? this.response,
      to: to ?? this.to,
      Studentclass: Studentclass ?? this.Studentclass,
      department: department ?? this.department,
      reason: reason ?? this.reason,
      rollno: rollno ?? this.rollno,
      createdAt: createdAt ?? this.createdAt, 
    );
  }
}
