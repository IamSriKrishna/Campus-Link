import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/model/event/event.dart';
import 'package:dio/dio.dart';

class EventController {
  final Dio _dio = Dio();

  Future<EventResponse> getEvent() async {
    try {
      Response res = await _dio.get(Url.getAllEvent,
          options: Options(headers: AppContent.headers));
      if (res.statusCode == 200) {
        return EventResponse.fromJson(res.data);
      } else {
        throw Exception("No Data");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> addView(
      {required String eventId, required String studentId}) async {
    try {
      Response res = await _dio.post(Url.addViews,
          options: Options(headers: AppContent.headers),
          data: {"eventId": eventId, "studentId": studentId});
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
