import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:campuslink/Feature/Screen/MyProfile/Widget/CustomProfileDetails.dart';
import 'package:campuslink/Feature/Service/PasswordService.dart';
import 'package:campuslink/Feature/Service/UpdateProfilePicture.dart';
import 'package:campuslink/Provider/DarkThemeProvider.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/Util/FontStyle/RobotoBoldFont.dart';
import 'package:campuslink/Util/FontStyle/RobotoRegularFont.dart';
import 'package:campuslink/Util/showsnackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  static const route = '/EditProfile';
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
    bool _isLoading = false;
    File? _image;
    Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } 
  }
  @override
  void dispose() {
    setState(() {
      _isLoading = false;
    });
    super.dispose();
  }
  void done(){
    
    //final my = Provider.of<StudentProvider>(context,listen: false).user;
    if(_confirmPassword.text.isEmpty && _image == null){
      showSnackBar(context: context, text: 'Profile Not updated');
          setState(() {
            _isLoading = false;
          });
    }
    else{
      if(_newPassword.text.isNotEmpty || _confirmPassword.text.isNotEmpty){
        if(_newPassword.text == _confirmPassword.text){
          PasswordService().updatePassword(_confirmPassword.text,context);
          setState(() {
            _isLoading = true;
          });
        }
      }
      else if(_image != null){
        ProfilePicture().UpdateProfilePicture(image: _image!,context: context);
          setState(() {
            _isLoading = true;
          });
      }
      else{
        showSnackBar(context: context, text: 'Password is mismatch');
          setState(() {
            _isLoading = false;
          });
      }
      
    }
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final my = Provider.of<StudentProvider>(context).user;
    final theme = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width *0.2,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top:16.0,left: 10),
            child: RobotoRegularFont(
              text: S.current.cancel,
              size: 14,
              textColor: theme.getDarkTheme?themeColor.themeColor:themeColor.appThemeColor,
            ),
          ),
        ),
        backgroundColor: theme.getDarkTheme?themeColor.darkTheme:themeColor.themeColor,
        actions: [
          InkWell(
            onTap: done,
            child: Padding(
              padding: const EdgeInsets.only(top:16.0,right: 10),
              child: RobotoRegularFont(
                text: 'Done',
                size: 14,
                textColor: Colors.blue,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          _isLoading?LinearProgressIndicator():Container(),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        color:  _image == null?Color.fromARGB(77, 167, 163, 163):Colors.transparent,
                        shape: BoxShape.circle,
                        image: _image == null ?DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: NetworkImage(my.dp)
                          ):DecorationImage(
                          fit: BoxFit.scaleDown,
                          image: FileImage(_image!)
                          )
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: _pickImage,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:8.0),
                    child: RobotoBoldFont(
                      textAlign: TextAlign.center,
                      text: 'Change Profile Picture',
                      textColor: Colors.blue,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomProfileDetails(
                        title: 'Name', 
                        hint: my.name,
                        left: width * 0.15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: CustomProfileDetails(
                          title: 'Register', 
                          hint: my.rollno,
                          left:  width * 0.1,
                        ),
                      ),
                      CustomProfileDetails(
                        title: 'Branch', 
                        hint: my.department,
                        left: width * 0.13,
                      ),
                      CustomProfileDetails(
                        title: 'Section', 
                        hint: my.Studentclass,
                        left: width * 0.13,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:8.0),
                        child: CustomProfileDetails(
                          title: 'Year', 
                          hint: my.year,
                          left: width * 0.19,
                        ),
                      ),
                      Text('\nChange Password',style: GoogleFonts.merriweatherSans(),),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: TextField(
                          controller: _newPassword,
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.luxuriousRoman(
                              color: theme.getDarkTheme ? Colors.grey:Colors.black,
                            ),
                            labelText: 'New password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:15.0),
                        child: TextField(
                          controller: _confirmPassword,
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.luxuriousRoman(
                              color: theme.getDarkTheme ? Colors.grey:Colors.black,
                            ),
                            labelText: 'Confirm password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}