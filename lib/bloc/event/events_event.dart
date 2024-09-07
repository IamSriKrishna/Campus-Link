abstract class EventsEvent {}

class GetEventsEvent extends EventsEvent {}

class AddViewEvent extends EventsEvent {
  final String studentId;
  final String eventId;
  AddViewEvent({required this.eventId, required this.studentId});
}
