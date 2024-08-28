import 'package:campuslink/Feature/Screen/Searchscreen/SearchScreen.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MainSearchAppBar extends StatelessWidget {
  const MainSearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<DarkThemeProvider>(context);
    return SliverAppBar(
      backgroundColor: theme.getDarkTheme?null:Colors.white,
      floating: true,
      leadingWidth: 40,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25,
            )),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                onTap: () {
                  Get.to(() => SearchScreen(),
                      duration: Duration(milliseconds: 0));
                },
                style: TextStyle(
                  color:
                      theme.getDarkTheme ? themeColor.appBarColor : Colors.grey,
                ),
                decoration: InputDecoration(
                  prefixIcon: Hero(
                      tag: 1,
                      child: Icon(
                        Icons.search,
                        color: theme.getDarkTheme
                            ? themeColor.appBarColor
                            : Colors.grey,
                      )),
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
          ],
        ),
      ),
    );
  }
}
