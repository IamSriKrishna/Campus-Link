import 'package:flutter/material.dart';
import 'package:campuslink/app/app_key.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/widget/search/search_student_widget.dart';
import 'package:provider/provider.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  _SearchStudentScreenState createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).refreshStudentData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        key: const PageStorageKey<String>(AppKey.studentSearch),
        slivers: [
          SearchStudentWidget.searchBar(context, _searchController),
          SearchStudentWidget.studentList(context),
        ],
      ),
    );
  }
}
