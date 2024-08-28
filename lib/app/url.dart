class Url {
  // http://192.168.29.17:8000 ,  http://65.2.137.77:3000
  static String ip = "65.2.137.77";
  static String port = "3000";
  static String ipWithPort = "$ip:$port";
  static String baseurl = "http://$ipWithPort";
  //form
  static String createForm = "$baseurl/kcg/student/form-upload";

  //post
  static String getAllPost = "$baseurl/post/getAllPostData";

  //student
  static String getStudentBySearch = "$baseurl/students/search";
  static String login = "$baseurl/kcg/student/signin";
  static String getStudentDataByID = "$baseurl/student";

  //fcm
  static String updateFcmToken = "$baseurl/kcg/student/fcm-token";
  static String sendNotification = "$baseurl/send-notification";
  //credit
  static String updateCredit(String id) =>
      "$baseurl/students/$id/update-credit";

  //follow/unfollow
  static String follow = "$baseurl/kcg/student/follow";
  static String unfollow = "$baseurl/kcg/student/unfollow";
  static String refreshFollow = "$baseurl/kcg/student/refreshfollow/";

  //chat
  static String createMessage = '$baseurl/send-message/';
  static String getMessage = '$baseurl/get-message';
  static String createChat = "$baseurl/create-chat/";
  static String getChat = "$baseurl/get-chat/";

  //websocket
  static String chatWebSocket = "ws://$ip:3005";
  static String webSocket = "ws://$ip:5005";
  static String messageWebSocket = "ws://$ip:5005";
}
