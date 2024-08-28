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
      PostModel? postModel = await _postdatabaseHelper.getPostModel();
      if (postModel != null) {
        return postModel;
      } else {
        throw Exception('Failed to load data and no local data available');
      }
    }
  }

  PostModel _parseJson(Map<String, dynamic> json) => PostModel.fromJson(json);
}
