abstract class StudentEvent {}

class StudentSearchEvent extends StudentEvent {
  final String name;
  StudentSearchEvent({required this.name});
}

class UpdateBioEvent extends StudentEvent {
  final String bio;
  UpdateBioEvent({required this.bio});
}
