import 'package:flutter/material.dart';
import 'package:campuslink/widget/components/helper_functions.dart';
import 'package:campuslink/widget/profile/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => HelperFunctions.refreshMyProfile(context),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            ProfileWidget.appBar(context),
            ProfileWidget.topWidget(context),
            ProfileWidget.nameAndBio(context),
            ProfileWidget.editProfile(),
            ProfileWidget.gridDivider(),
            ProfileWidget.gridPost()
          ],
        ),
      ),
    );
  }
}
