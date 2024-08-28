import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:campuslink/Feature/Screen/OverScreen/OverScreen.dart';
import 'package:campuslink/Model/Chat/InitialChat.dart';
import 'package:campuslink/Model/Chat/get_chat.dart';
import 'package:campuslink/Util/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatHelper {
  static var client = http.Client();

  static Future<List<dynamic>> apply(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('studenttoken');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$token'
    };

    var url = Uri.http(halfuri, "/create-chat/");
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode({"userId": id}));

    if (response.statusCode == 200) {
      var first = initialChatFromJson(response.body).id;
      return [true, first];
    } else {
      return [false, "Failed to create chat"];
    }
  }

  static Future<List<GetChats>> getConversations() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('studenttoken');
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': "$token"
    };

    var url = Uri.http(halfuri, '/get-chat/');
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var chats = getChatsFromJson(response.body);
      return chats;
    } else {
      throw Exception("Couldn't load chats");
    }
  }

    static Future<bool> deleteChat(String chatId,BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('studenttoken');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': '$token'
    };

    var url = Uri.http(halfuri, '/delete-chat/'); // Adjust the URL accordingly
    var response = await client.delete(
      url,
      headers: requestHeaders,
      body: jsonEncode({"chatId": chatId}), // Send the chat ID to be deleted
    );

    if (response.statusCode == 200) {
      Navigator.pushNamedAndRemoveUntil(
        context, 
        OverScreen.route, (route) => false);
      return true; // Chat deleted successfully
    } else {
      return false; // Failed to delete chat
    }
  }

}
