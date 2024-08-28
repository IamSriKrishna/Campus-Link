import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SearchAppBar extends StatefulWidget {
  final TextEditingController name;
  final void Function(String)? onChanged;
  const SearchAppBar({super.key,required this.onChanged,required this.name});

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return SliverAppBar(
      floating: true,
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back,size: 25,)),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: TextField(
          style: TextStyle(
                  color: theme.getDarkTheme
                      ? themeColor.appBarColor
                      : Colors.grey,),
          controller: widget.name,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: theme.getDarkTheme
                  ? themeColor.appBarColor
                  : Colors.grey,
            ),
            hintText: 'Search Student',
            hintStyle: TextStyle(
                color: theme.getDarkTheme
                    ? themeColor.appBarColor
                    : const Color.fromARGB(255, 0, 0, 0)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding:
                EdgeInsets.all(10.0), // Adjust vertical padding
          ),
        ),
      ),
      foregroundColor: theme.getDarkTheme ? Colors.white : const Color.fromARGB(255, 0, 0, 0),
      backgroundColor: Color.fromARGB(0, 255, 97, 97),
    );
  }
}