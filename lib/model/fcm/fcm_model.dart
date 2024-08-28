class FcmModel {
  final String fcmtoken;
  FcmModel({this.fcmtoken = "no-fcmtoken"});
  factory FcmModel.fromJson(Map<String, dynamic> json) {
    return FcmModel(fcmtoken: json["fcmtoken"]);
  }

  Map<String, dynamic> toJson() {
    return {"fcmtoken": fcmtoken};
  }
}
