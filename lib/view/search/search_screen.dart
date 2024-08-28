import 'package:flutter/material.dart';
import 'package:campuslink/app/app_key.dart';
import 'package:campuslink/widget/components/helper_functions.dart';
import 'package:campuslink/widget/search/search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          return await HelperFunctions.refreshContentOfSearchPostWithShuffle(
              context);
        },
        child: CustomScrollView(
          key: const PageStorageKey<String>(AppKey.search),
          physics: const BouncingScrollPhysics(),
          slivers: [SearchWidget.search(), SearchWidget.staggeredGrid()],
        ),
      ),
    );
  }
}
