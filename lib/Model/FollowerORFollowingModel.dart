import 'dart:convert';

class FollowerORFollowingModel {
  final List<dynamic> followers;
  final List<dynamic> following;
  FollowerORFollowingModel({
    required this.followers,
    required this.following
  });

  Map<String, dynamic> toMap() {
    return {
      'following':following,
      'followers':followers,
    };
  }

  factory FollowerORFollowingModel.fromMap(Map<String, dynamic> map) {
    return FollowerORFollowingModel(
      followers:map['followers']??[],
      following:map['following']??[],
    );
  }

  String toJson() => json.encode(toMap());

  factory FollowerORFollowingModel.fromJson(String source) => FollowerORFollowingModel.fromMap(json.decode(source));

  FollowerORFollowingModel copyWith({
    List<dynamic>? following,
    List<dynamic>? followers,
  }) {
    return FollowerORFollowingModel(
      followers: followers??this.followers,
      following: following??this.following,

    );
  }
}