
import 'package:flutter/material.dart';
import 'package:campuslink/Model/Student.dart';

class StudentProvider extends ChangeNotifier {
  Student _user = Student(
      id: '',
      name: '',
      blocked:false,
      fcmtoken: '',
      certified:false,
      rollno: '',
      password: '',
      followers: [],
      following: [],
      year: '',
      bio:'',
      Studentclass: '',
      credit: 0,
      department: '',
      dp: '',
      token: '',
  );

  Student get user => _user;
  
  void setUser(String user) {
    _user = Student.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Student user) {
    _user = user;
    notifyListeners();
  }

  
  void signOut() {
    _user = Student(
      id: '',
      name: '',
      blocked: false,
      fcmtoken: '',
      certified:false,
      bio:'',
      rollno: '',
      password: '',
      year: '',
      followers: [],
      following: [],
      Studentclass: '',
      credit: 0,
      department: '',
      dp: '',
      token: '',
    );
    
    notifyListeners();
  }
}