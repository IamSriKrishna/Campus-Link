import 'package:dio/dio.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/model/fcm/fcm.dart';
import 'package:campuslink/model/fcm/fcm_model.dart';

class FcmController {
  final Dio _dio = Dio();
  Future<bool> updateFcmToken({
    required String id,
    required String fcmtoken,
  }) async {
    try {
      FcmModel fcmModel = FcmModel(fcmtoken: fcmtoken);
      Response res = await _dio.put("${Url.updateFcmToken}/$id",
          options: Options(headers: AppContent.headers),
          data: fcmModel.toJson());
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> sendNotification({
    required String title,
    required String body,
    required String token,
  }) async {
    final Fcm fcm = Fcm(title: title, body: body, token: token);
    try {
      Response res = await _dio.post(Url.sendNotification,
          options: Options(headers: AppContent.headers), data: fcm.toJson());
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
