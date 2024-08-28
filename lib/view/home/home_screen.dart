import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/app/app_key.dart';
import 'package:campuslink/bloc/student/student_bloc.dart';
import 'package:campuslink/bloc/student/student_event.dart';
import 'package:campuslink/view/chat/chat_screen.dart';
import 'package:campuslink/widget/components/helper_functions.dart';
import 'package:campuslink/widget/home/home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    context.read<StudentBloc>().add(FetchStudentEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const PageScrollPhysics(),
        children: [
          RefreshIndicator(
            onRefresh: () => HelperFunctions.refreshContentOfReadPost(context),
            child: CustomScrollView(
              key: const PageStorageKey<String>(AppKey.post),
              physics: const BouncingScrollPhysics(),
              slivers: [
                HomeWidget.sliverAppBar(onTap: () {
                  if (_pageController.page != 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                }),
                HomeWidget.story(context),
                HomeWidget.post(),
              ],
            ),
          ),
          ChatScreen(
            onTap: () {
              if (_pageController.page != 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ), // Your new chat page
        ],
      ),
    );
  }
}
