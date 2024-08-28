import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:campuslink/Model/FollowerORFollowingModel.dart';
import 'package:campuslink/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
class FollowersOrFollowing{
  Future<String> addFollower(String followerId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = await prefs.getString('userId');
    final response = await http.post(
      Uri.parse('$uri/students/addfollowers'),
      body: jsonEncode({'studentId': studentId, 'followerId': followerId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return "Follower added successfully";
    } else {
      throw Exception("Failed to add follower");
    }
  }

  Future<String> addFollowerbyThirdUser(String followerId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = await prefs.getString('userId');
    final response = await http.post(
      Uri.parse('$uri/students/addfollowers'),
      body: jsonEncode({'studentId': followerId, 'followerId': studentId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return "Follower added successfully";
    } else {
      throw Exception("Failed to add follower");
    }
  }
  Future<String> addFollowing(String followingId) async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = await prefs.getString('userId');
    print(studentId);
    final response = await http.post(
      Uri.parse('$uri/students/addFollowing'),
      body: jsonEncode({'studentId': studentId, 'followingId': followingId}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return "Following added successfully";
    } else {
      throw Exception("Failed to add following");
    }
    }catch(e){
      print(e);
      throw Exception("Failed to add following");
    }
  }

    Future<int> getFollowersCount(String ThirduserId) async {
    final response = await http.get(
      Uri.parse('$uri/students/followersCount/$ThirduserId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['followersCount'] as int;
    } else {
      throw Exception("Failed to fetch followers count");
    }
  }

  Future<int> getMyFollowingCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = await prefs.getString('userId');
    final response = await http.get(
      Uri.parse('$uri/students/followingCount/$studentId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['followingCount'] as int;
    } else {
      throw Exception("Failed to fetch following count");
    }
  }


      Future<int> getMyFollowersCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? studentId = await prefs.getString('userId');
    final response = await http.get(
      Uri.parse('$uri/students/followersCount/$studentId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['followersCount'] as int;
    } else {
      throw Exception("Failed to fetch followers count");
    }
  }

  Future<int> getFollowingCount(String ThirduserId) async {
    final response = await http.get(
      Uri.parse('$uri/students/followingCount/$ThirduserId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['followingCount'] as int;
    } else {
      throw Exception("Failed to fetch following count");
    }
  }

    Future<List<dynamic>> getFollowers(String studentId) async {
    final response = await http.get(
      Uri.parse('$uri/students/getFollowers/$studentId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      return data['followers'] as List<dynamic>;
    } else {
      throw Exception("Failed to fetch followers");
    }
  }

  Future<List<FollowerORFollowingModel>> getFollowing(String studentId) async { 
    List<FollowerORFollowingModel> getFollowing = [];
    final response = await http.get(
      Uri.parse('$uri/students/getFollowing/$studentId'),
    );

    if (response.statusCode == 200) {
      for (int i = 0; i < jsonDecode(response.body).length; i++) {
            getFollowing.add(
              FollowerORFollowingModel.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
    } else {
      throw Exception("Failed to fetch following");
    }
    return getFollowing;
  }
}