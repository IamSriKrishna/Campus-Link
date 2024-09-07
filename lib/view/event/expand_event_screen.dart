import 'package:campuslink/bloc/event/events_bloc.dart';
import 'package:campuslink/bloc/event/events_event.dart';
import 'package:campuslink/model/event/event.dart';
import 'package:campuslink/widget/event/expand_event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpandEventScreen extends StatefulWidget {
  final Event event;
  final String studentId;
  const ExpandEventScreen(
      {super.key, required this.studentId, required this.event});

  @override
  State<ExpandEventScreen> createState() => _ExpandEventScreenState();
}

class _ExpandEventScreenState extends State<ExpandEventScreen> {
  @override
  void initState() {
    context.read<EventsBloc>().add(
        AddViewEvent(eventId: widget.event.id, studentId: widget.studentId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              ExpandEventWidget.sliverAppBar(
                event: widget.event,
              ),
              ExpandEventWidget.titleAndView(
                event: widget.event,
              ),
              ExpandEventWidget.description(
                event: widget.event,
              ),
            ],
          ),
          ExpandEventWidget.floatingButton(event: widget.event),
        ],
      ),
    );
  }
}
