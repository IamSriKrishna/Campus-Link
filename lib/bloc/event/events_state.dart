import 'package:campuslink/model/event/event.dart';

abstract class EventsState {}

class InitialEventsState extends EventsState {}

class LoadingEventsState extends EventsState {}

class SuccessEventsState extends EventsState {}

class FailedEventsState extends EventsState {
  final String error;
  FailedEventsState({required this.error});
}

class UpdateEventsState extends EventsState {
  final bool isLoading;
  UpdateEventsState({required this.isLoading});
}

class GetEventsState extends EventsState {
  final EventResponse eventResponse;
  GetEventsState({required this.eventResponse});
}
