import 'package:campuslink/handler/event/event_handler.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/widget/event/event_widget.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  void initState() {
    super.initState();
    EventsHandler.startPeriodicEvents(context);
  }

  @override
  void dispose() {
    EventsHandler.stopPeriodicEvents();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          EventWidget.sliverAppBar(),
          EventWidget.listEvent(context),
        ],
      ),
    );
  }
}
