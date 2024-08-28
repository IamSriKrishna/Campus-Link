import 'package:dio/dio.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/model/follow/follow.dart';

class FollowController {
  final Dio _dio = Dio();

  Future<bool> addFollow(String followerId, String followeeId) async {
    try {
      final Follow follow =
          Follow(followerId: followerId, followeeId: followeeId);
      final response = await _dio.post(
        Url.follow,
        options: Options(headers: AppContent.headers),
        data: follow.toJson(),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to follow user');
    }
  }

  Future<bool> removeFollow(String followerId, String followeeId) async {
    try {
      final Follow follow =
          Follow(followerId: followerId, followeeId: followeeId);
      final response = await _dio.post(
        Url.unfollow,
        options: Options(headers: AppContent.headers),
        data: follow.toJson(),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to unfollow user');
    }
  }
}
