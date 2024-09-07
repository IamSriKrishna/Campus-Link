import 'package:dio/dio.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/app/app_query.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/db/student_database.dart';
import 'package:campuslink/model/student/student.dart';
import 'package:flutter/material.dart';

class StudentController {
  final Dio _dio = Dio();
  final StudentDatabaseHelper _studentDatabaseHelper = StudentDatabaseHelper();
  //Search Student by Name
  Future<StudentModel> getSearchByName({required String name}) async {
    try {
      Response res = await _dio.get(Url.getStudentBySearch,
          options: Options(headers: AppContent.headers),
          queryParameters: {AppQuery.name: name});
      if (res.statusCode == 200) {
        StudentModel studentModel = _parseJson(res.data);
        await _studentDatabaseHelper.saveStudentModel(studentModel);
        return studentModel;
      } else {
        throw Exception('Failed to load student data');
      }
    } catch (e) {
      StudentModel? studentModel =
          await _studentDatabaseHelper.getStudentModel();
      if (studentModel != null) {
        return studentModel;
      } else {
        throw Exception('Failed to load data and no local data available');
      }
    }
  }

 

  Future<bool> updateBio({
    required String studentId,
    required String bio,
  }) async {
    try {
      Response res = await _dio.post(Url.updateBio,
          options: Options(headers: AppContent.headers),
          data: {"bio": bio, "studentId": studentId});
      debugPrint(res.statusCode.toString());
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  StudentModel _parseJson(Map<String, dynamic> json) =>
      StudentModel.fromJson(json);
}
