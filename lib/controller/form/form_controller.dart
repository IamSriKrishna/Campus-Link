import 'package:dio/dio.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/model/form/form.dart';

class FormController {
  final Dio _dio = Dio();

  //Create Form
  Future<bool> createForm({
    required String name,
    required String department,
    required String year,
    required String reason,
    required String from,
    required String to,
    required int spent,
    required String formtype,
    required String studentClass
  }) async {
    Form form = Form(
        name: name,
        department: department,
        reason: reason,
        formtype: formtype,
        studentClass: studentClass,
        year: year,
        from: from,
        spent: spent,
        to: to);
    try {
      Response res = await _dio.post(Url.createForm,
          options: Options(headers: AppContent.headers), data: form.toJson());
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
