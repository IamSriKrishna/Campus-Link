import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:campuslink/Model/Chat/ReceiveMessage.dart';
import 'package:campuslink/Model/Chat/sendMessage.dart';
import 'package:campuslink/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MesssagingHelper {
  static var client = http.Client();

  // Apply for job
  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('studenttoken');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$token'
    };

    var url = Uri.http(halfuri, '/send-message/');

    try {
      var response = await http.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        ReceivedMessge message =
            ReceivedMessge.fromJson(jsonDecode(response.body));
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        return [true, message, responseMap];
      } else {
        return [false];
      }
    } catch (e) {
      // Handle any exceptions here
      print('Exception occurred while sending message: $e');
      return [false];
    }
  }

  static Future<List<ReceivedMessge>> getMessages(
      String chatId, int offset) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('studenttoken');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$token'
    };

    try {
      var url = Uri.http(
          halfuri, "/get-message/$chatId", {"page": offset.toString()});
      var response = await client.get(
        url,
        headers: requestHeaders,
      );

      if (response.statusCode == 200) {
        var messages = receivedMessgeFromJson(response.body);
        return messages;
      } else {
        throw Exception("Failed to load messages");
      }
    } catch (e) {
      print("Error fetching messages: $e");
      throw Exception("Failed to load messages");
    }
  }
}
