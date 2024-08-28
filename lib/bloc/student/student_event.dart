abstract class StudentEvent {}

class StudentSearchEvent extends StudentEvent {
  final String name;
  StudentSearchEvent({required this.name});
}

class FetchStudentEvent extends StudentEvent {}
