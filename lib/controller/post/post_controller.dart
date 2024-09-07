import 'dart:io';
import 'package:dio/dio.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/db/post_database.dart';
import 'package:campuslink/model/post/post.dart';

class PostController {
  final Dio _dio = Dio();
  final PostDatabaseHelper _postdatabaseHelper = PostDatabaseHelper();

  Future<PostModel> readPostData() async {
    try {
      Response res = await _dio.get(
        Url.getAllPost,
        options: Options(headers: AppContent.headers),
      );

      if (res.statusCode == 200) {
        PostModel postModel = _parseJson(res.data);
        await _postdatabaseHelper.savePostModel(postModel);
        return postModel;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      if (e is SocketException) {
        PostModel? postModel = await _postdatabaseHelper.getPostModel();
        if (postModel != null) {
          return postModel;
        } else {
          throw Exception('No local data available while offline');
        }
      } else {
        // Handle other errors
        throw Exception('Failed to load data: ${e.toString()}');
      }
    }
  }

  Future<bool> likePost(
      {required String studentId, required String postId}) async {
    try {
      Response res = await _dio.post(Url.likePost,
          options: Options(headers: AppContent.headers),
          data: {"postId": postId, "studentId": studentId});
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  PostModel _parseJson(Map<String, dynamic> json) => PostModel.fromJson(json);

}
