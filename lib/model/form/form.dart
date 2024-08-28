class Form {
  final String name;
  final String rollno;
  final String dp;
  final String department;
  final String formtype;
  final String studentClass;
  final String year;
  final String reason;
  final int noOfDays;
  final String from;
  final String to;
  final String studentId;
  final int spent;
  final String fcmtoken;

  Form({
    this.name = "no-name",
    this.rollno = "no-rollno",
    this.dp = "no-dp",
    this.department = "no-department",
    this.formtype = "no-formtype",
    this.studentClass = "no-studentClass",
    this.year = "no-year",
    this.reason = "no-reason",
    this.noOfDays = 0,
    this.from = "no-from",
    this.to = "no-to",
    this.studentId = "no-studentId",
    this.spent = 0,
    this.fcmtoken = "no-fcmtoken",
  });

  factory Form.fromJson(Map<String, dynamic> json) {
    return Form(
      name: json['name'],
      rollno: json['rollno'],
      dp: json['dp'],
      department: json['department'],
      formtype: json['formtype'],
      studentClass: json['Studentclass'],
      year: json['year'],
      reason: json['reason'],
      noOfDays: json['no_of_days'],
      from: json['from'],
      to: json['to'],
      studentId: json['studentid'],
      spent: json['spent'],
      fcmtoken: json['fcmtoken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'rollno': rollno,
      'dp': dp,
      'department': department,
      'formtype': formtype,
      'Studentclass': studentClass,
      'year': year,
      'reason': reason,
      'no_of_days': noOfDays,
      'from': from,
      'to': to,
      'studentid': studentId,
      'spent': spent,
      'fcmtoken': fcmtoken,
    };
  }

  Form copyWith({
    String? name,
    String? rollno,
    String? dp,
    String? department,
    String? formtype,
    String? studentClass,
    String? year,
    String? reason,
    int? noOfDays,
    String? from,
    String? to,
    String? studentId,
    int? spent,
    String? fcmtoken,
  }) {
    return Form(
      name: name ?? this.name,
      rollno: rollno ?? this.rollno,
      dp: dp ?? this.dp,
      department: department ?? this.department,
      formtype: formtype ?? this.formtype,
      studentClass: studentClass ?? this.studentClass,
      year: year ?? this.year,
      reason: reason ?? this.reason,
      noOfDays: noOfDays ?? this.noOfDays,
      from: from ?? this.from,
      to: to ?? this.to,
      studentId: studentId ?? this.studentId,
      spent: spent ?? this.spent,
      fcmtoken: fcmtoken ?? this.fcmtoken,
    );
  }
}
