abstract class FormEvent {}

class CreateFormEvent extends FormEvent {
  final String name;
  final String department;
  final String year;
  final String reason;
  final String from;
  final String studentClass;
  final String formtype;
  final int spent;
  final String to;
  CreateFormEvent(
      {required this.department,
      required this.from,
      required this.name,
      required this.formtype,
      required this.studentClass,
      required this.reason,
      required this.spent,
      required this.to,
      required this.year});
}
