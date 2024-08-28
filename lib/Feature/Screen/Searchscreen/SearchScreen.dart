import 'dart:convert';

import 'package:campuslink/Feature/Screen/3rdUserProfile/ThirdUserProfile.dart';
import 'package:campuslink/Feature/Screen/Searchscreen/Widget/SearchAppBar.dart';
import 'package:campuslink/Feature/Service/NotificationService.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:campuslink/Util/util.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  NotificationService _notificationService = NotificationService();
  final List<String> mostSearch = [
    "Sri Krishna",
    "Krithick",
    "Nithyashree",
    "Vignesh S",
    "Ravindranath",
    "Sheik Mohamed"
  ];

  List<Map<String, dynamic>> searchResults = [];
  late TextEditingController _searchController;
  bool _searched = false;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchData(String name) async {
    final response = await http.get(
      Uri.parse('$uri/students/search?name=$name'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _searched = false;
        searchResults =
            List<Map<String, dynamic>>.from(jsonDecode(response.body));
      });
    } else {
      setState(() {
        _searched = true;
      });
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SearchAppBar(
            name: _searchController,
            onChanged: (value) {
              fetchData(value);
            },
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 52.5,
              width: double.infinity,
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                slivers: [
                  SliverList.builder(
                    itemCount: mostSearch.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: index == 0 ? 0 : 8.0, top: 10),
                        child: InkWell(
                          onTap: () {
                            final searchTerm = mostSearch[index];
                            _searchController.text =
                                searchTerm; // Set the tapped item to the text field
                            fetchData(
                                searchTerm); // Fetch data associated with the tapped item
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Color.fromARGB(99, 107, 107, 107),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Transform.rotate(
                                      angle: 100,
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 8.0,
                                      right: index == 0 || index == 1 ? 2 : 10),
                                  child: Text(
                                    mostSearch[index],
                                    style: GoogleFonts.andika(fontSize: 18),
                                  ),
                                ),
                                index == 0 || index == 1
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            right: 5, bottom: 10),
                                        child: Image.asset(
                                          'asset/tick.png',
                                          height: 15,
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          SliverList.builder(
            itemCount:_searched == false? searchResults.length:1,
            itemBuilder: (context, index) {
              final result = searchResults[index];
              if (_searched == false) {
                return DelayedDisplay(
                  delay: Duration(milliseconds: 350 * index),
                  child: InkWell(
                    onTap: () {
                  
                      _notificationService.sendNotifications(
                          context: context,
                          toAllFaculty: [result['fcmtoken']],
                          body: '${student.name} Viewed Your Profile!');
                  
                      Get.to(() => ThirdUserProfile(
                          name: result['name'],
                          index: result['_id'],
                          department: result['department'],
                          rollno: result['rollno'],
                          dp: result['dp'],
                          certified: result['certified'],
                          id: result['_id'],
                          fcmtoken: result['fcmtoken'],
                          current_student_id: student.id));
                      print(result['fcmtoken'] == null);
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(result['name']),
                          result['certified'] == true
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 5, bottom: 10, left: 2),
                                  child: Image.asset(
                                    'asset/tick.png',
                                    height: 15,
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      subtitle: Text(result['department']),
                      leading: Hero(
                        tag: result['_id'],
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(result['dp']),
                        ),
                      ),
                      // You can customize the ListTile as per your requirement
                    ),
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top:100.0),
                  child: Center(
                    child: Text(
                      "Wierd Name;)\nNo Student Found",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
