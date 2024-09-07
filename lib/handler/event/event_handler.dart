import 'dart:async';

import 'package:campuslink/bloc/event/events_bloc.dart';
import 'package:campuslink/bloc/event/events_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsHandler {
  static Timer? _timer;

  static void startPeriodicEvents(BuildContext context) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (context.mounted) {
        context.read<EventsBloc>().add(GetEventsEvent());
      }
    });
  }

  static void stopPeriodicEvents() {
    _timer?.cancel();
  }
}
