// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'package:campuslink/CleanWidget/customspinkit.dart';
import 'package:campuslink/Feature/Service/NotificationService.dart';
import 'package:campuslink/Feature/Service/postService.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/Widget/CustomButton.dart';
import 'package:campuslink/Widget/CustomTextField.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AddPostScreen extends StatefulWidget {
  static const String routeName = '/AddPostScreen';
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final AddPostService adminServices = AddPostService();
  List<Map<String, dynamic>> fetchStudents = [];
  Future<void> fetchForm() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final a = pref.getString('x-auth-token');
    final res = await http.get(
      Uri.parse('$uri/kcg/students/notify'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "x-auth-token": a!
      },
    );
    if (res.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(res.body);
      final List<dynamic> studentsData = data['data'];
      setState(() {
        fetchStudents = List<Map<String, dynamic>>.from(studentsData);
      });
    } else {
      throw Exception('Failed to load data');
    }
     
  }
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();
  bool _link = false;
  bool _notify = false;

  bool _load = false;
  void sellProduct(
      {required String description,
      required String title,
      required String link}) {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.uploadPost(
          context: context,
          pdfUrl:'Null',
          description: description,
          title: title,
          myClass: 'Student',
          link: link,
          images: images);
      setState(() {
        _load = true;
      });
    }
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void initState() {
    fetchForm();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final student = Provider.of<StudentProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    images.isNotEmpty
                        ? CarouselSlider(
                            items: images.map(
                              (i) {
                                return Builder(
                                  builder: (BuildContext context) => Image.file(
                                    i,
                                    fit: BoxFit.fill,
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                );
                              },
                            ).toList(),
                            options: CarouselOptions(
                              viewportFraction: 1,
                            ),
                          )
                        : GestureDetector(
                            onTap: selectImages,
                            child: DottedBorder(
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(10),
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              child: Container(
                                width: double.infinity,
                                height: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.folder_open,
                                      size: 40,
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Select Images',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      controller: titleController,
                      hintText: 'Title',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: descriptionController,
                      hintText: 'Description',
                      maxLines: 7,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: Colors.black,
                          value: _link,
                          onChanged: (value) {
                            setState(() {
                              _link = !_link;
                            });
                          },
                        ),
                        Text('Link')
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Notify All Students',
                          style: GoogleFonts.merriweather(fontSize: 18),
                        ),
                        Checkbox(
                          activeColor: Colors.black,
                          value: _notify,
                          onChanged: (value) {
                            setState(() {
                              _notify = !_notify;
                            });
                          },
                        )
                      ],
                    ),
                    _link
                        ? CustomTextField(
                            controller: linkController,
                            hintText: 'Link',
                          )
                        : Container(),
                    const SizedBox(height: 20),
                    CustomButton(
                        text: 'Upload',
                        onTap: () {
                          if (_notify == true) {
                            for (int i = 0; i < fetchStudents.length; i++) {
                              if (fetchStudents[i]['fcmtoken'] != null) {
                                NotificationService().sendNotifications(
                                    context: context,
                                    toAllFaculty: [fetchStudents[i]['fcmtoken']],
                                    body: "Check out what ${student.name.toLowerCase()} just posted on Campus~Link!");
                              }
                            }
                            
                            sellProduct(
                                description: descriptionController.text,
                                title: titleController.text,
                                link: _link == false
                                    ? 'null'
                                    : linkController.text);
                          } else {
                            sellProduct(
                                description: descriptionController.text,
                                title: titleController.text,
                                link: _link == false
                                    ? 'null'
                                    : linkController.text);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
          _load == true ? CustomSpinkit() : Container()
        ],
      ),
    );
  }
}
