// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:campuslink/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Model/post.dart';
import 'package:campuslink/Util/Additional/error_handling.dart';
import 'package:campuslink/Util/Additional/snackbar.dart';
import 'package:campuslink/Util/util.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class AddPostService{
   Future<void> uploadPost({
    required BuildContext context,
    required String description,
    required String title,
    required String myClass,
    required String link,
    required String pdfUrl,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<StudentProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dadtmv9ma', 't154mm7k');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: 'Post'),
        );
        imageUrls.add(res.secureUrl);
      }

      Post post = Post(
          id: '',
          name: userProvider.user.name,
          dp: userProvider.user.dp,
          pdfUrl: pdfUrl,
          image_url: imageUrls,
          senderId: userProvider.user.id,
          myClass: myClass,
          certified: userProvider.user.certified==true?'Yes':'No',
          link: link,
          likes: [],
          description: description,
          title: title,
          createdAt: DateTime.now());
      http.Response res = await http.post(
        Uri.parse('$uri/post/faculty/createPostData'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: post.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          await Get.off(() => const OverScreen());
        },
      );
    } catch (error) {
      print('Failed:$error');
    }
  }
  Future<List<Post>> DisplayAllForm(
  {
    required BuildContext context,
  }
  )async{
    List<Post> form = [];
    try {
      
      http.Response res = await http.get(
        Uri.parse('$uri/post/getAllPostData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            form.add(
              Post.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return form;
  }
    Future<void> deletePost(String postID,BuildContext context) async {

    final userProvider = Provider.of<StudentProvider>(context, listen: false);
    try {
      final response = await http.delete(
        Uri.parse('$uri/post/delete/$postID'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': userProvider.user.token,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData['msg']); // Log success message
        // You can handle success here, like navigating back to the previous screen
      } else if (response.statusCode == 404) {
        final responseData = json.decode(response.body);
        print(responseData['msg']); // Log error message
        // Handle post not found error
      } else {
        // Handle other status codes
        print('Something went wrong');
      }
    } catch (error) {
      // Handle error
      print('Something went wrong: $error');
    } 
  }

}