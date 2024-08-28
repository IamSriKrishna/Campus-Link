import 'package:campuslink/controller/auth/auth_controller.dart';
import 'package:campuslink/controller/chat/chat_controller.dart';
import 'package:campuslink/controller/credit/credit_controller.dart';
import 'package:campuslink/controller/fcm/fcm_controller.dart';
import 'package:campuslink/controller/follow/follow_controller.dart';
import 'package:campuslink/controller/form/form_controller.dart';
import 'package:campuslink/controller/message/message_controller.dart';
import 'package:campuslink/controller/post/post_controller.dart';
import 'package:campuslink/controller/student/student_controller.dart';
import 'package:campuslink/handler/socket/socket_handler.dart';

class AppController {
  //controller
  static FormController formController = FormController();
  static PostController postController = PostController();
  static StudentController studentController = StudentController();
  static AuthController authController = AuthController();
  static FcmController fcmController = FcmController();
  static CreditController creditController = CreditController();
  static FollowController followController = FollowController();
  static ChatController chatController = ChatController();
  static MessageController messageController = MessageController();

  //websocket
  static WebSocketService webSocketService = WebSocketService();
}
