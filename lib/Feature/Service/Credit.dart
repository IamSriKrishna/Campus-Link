import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:campuslink/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StudentCredit{
  Future<void> updateStudentCredit(String studentId, int amountToDeduct) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    final String apiUrl = '$uri/students/$studentId/update-credit';

    final Map<String, dynamic> data = {'credit': amountToDeduct};

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      //print('Credit updated successfully');
      // You can handle success here
    } else {
      //print('Failed to update credit');
      
      //print(response.body);
      //print(data);
      // Handle error here
    }
  }

  Future<void> updateStudentCreditToZero(String studentId, int amountToDeduct) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    final String apiUrl = '$uri/students/$studentId/update-credit-zero';

    final Map<String, dynamic> data = {'zero': amountToDeduct};

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token!
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      //print('Credit updated successfully');
      // You can handle success here
    } else {
      //print('Failed to update credit');
      //print(response.body);
      // Handle error here
    }
  }
}