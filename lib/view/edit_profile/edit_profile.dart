import 'package:campuslink/widget/edit_profile/edit_profile_widget.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          EditProfileWidget.sliverAppBar(),
          EditProfileWidget.profilePicture(),
          EditProfileWidget.unEditableTextField(),
          EditProfileWidget.bio()
        ],
      ),
    );
  }
}
