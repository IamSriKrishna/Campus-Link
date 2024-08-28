class Fcm {
  final String title;
  final String body;
  final String token;
  Fcm({this.body = "", this.title = "", this.token = ""});

  factory Fcm.fromJson(Map<String, dynamic> json) {
    return Fcm(
      title: json['title'],
      body: json['body'],
      token: json['registrationToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "body": body,
      "registrationToken": token,
    };
  }
}
