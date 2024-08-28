import 'package:dio/dio.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/model/credit/credit.dart';

class CreditController {
  final Dio _dio = Dio();

  Future<bool> updateCredit({required String id, required int credit}) async {
    Credit credits = Credit(credit: credit);
    final String url = "${Url.baseurl}/students/$id/update-credit";
    try {
      Response res = await _dio.put(url,
          options: Options(headers: AppContent.headers),
          data: credits.toJson());
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
