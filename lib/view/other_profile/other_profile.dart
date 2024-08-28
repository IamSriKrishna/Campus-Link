import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';
import 'package:campuslink/handler/other/other_handler.dart';
import 'package:campuslink/model/student/student.dart';
import 'package:campuslink/widget/profile/follow_widget.dart';
import 'package:campuslink/widget/profile/other_profile_widget.dart';

class OtherProfile extends StatefulWidget {
  final Student student;
  const OtherProfile({super.key, required this.student});

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = OtherHandler.startPeriodicUpdates(() => setState(() {}));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          OtherProfileWidget.appBar(context, student: widget.student),
          OtherProfileWidget.topWidget(context, student: widget.student),
          OtherProfileWidget.nameAndBio(context, student: widget.student),
          FollowWidget(
            student: widget.student,
          ),
          OtherProfileWidget.gridDivider(),
          OtherProfileWidget.gridPost()
        ],
      ),
    );
  }
}
