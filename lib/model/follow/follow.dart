class Follow {
  final String followerId;
  final String followeeId;

  Follow({
    this.followerId = "",
    this.followeeId = "",
  });

  factory Follow.fromJson(Map<String, dynamic> json) {
    return Follow(
      followerId: json['followerId'],
      followeeId: json['followeeId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'followerId': followerId,
      'followeeId': followeeId,
    };
  }
}
