import 'package:campuslink/model/student/student.dart';
import 'package:campuslink/model/student/student_with_following.dart';

abstract class StudentState {}

class InitialStudentState extends StudentState {}

class LoadingStudentState extends StudentState {}

class InitialSuccessStudentState extends StudentState {}

class SuccessStudentState extends StudentState {}

class FailedStudentState extends StudentState {
  final String error;
  FailedStudentState({required this.error});
}

class FetchStudentSuccessState extends StudentState {
  final StudentWithFollowing student;

  FetchStudentSuccessState({required this.student});
}

class ReadSearchStudentState extends StudentState {
  final StudentModel studentModel;
  ReadSearchStudentState({required this.studentModel});
}

// student_state.dart
class NoResultFoundState extends StudentState {
  final String name;

  NoResultFoundState({required this.name});
}
