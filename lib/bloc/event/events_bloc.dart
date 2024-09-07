import 'package:campuslink/bloc/event/events_event.dart';
import 'package:campuslink/bloc/event/events_state.dart';
import 'package:campuslink/controller/event/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final EventController _eventController;
  EventsBloc(this._eventController) : super(InitialEventsState()) {
    on<GetEventsEvent>((event, emit) async {
      //emit(LoadingEventsState());
      try {
        final eventResponse = await _eventController.getEvent();
        emit(GetEventsState(eventResponse: eventResponse));
      } catch (e) {
        emit(FailedEventsState(error: e.toString()));
      }
    });

    on<AddViewEvent>((event, emit) async {
      //emit(LoadingEventsState());
      try {
        final eventResponse = await _eventController.addView(
            eventId: event.eventId, studentId: event.studentId);
        if (eventResponse) {
          emit(SuccessEventsState());
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(FailedEventsState(error: e.toString()));
      }
    });
  }
}
