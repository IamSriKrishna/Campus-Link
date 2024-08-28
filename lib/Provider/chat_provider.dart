import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campuslink/Feature/Service/Chat/ChatService.dart';
import 'package:campuslink/Model/Chat/get_chat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  List<String> _online = [];
  bool _typing = false;
  bool get typing => _typing;

  set typingStatus(bool newState) {
    _typing = newState;
    notifyListeners();
  }

  List<String> get online => _online;

  set onlineUsers(List<String> newList) {
    _online = newList;
    notifyListeners();
  }

  String? userId;

  getChats() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }


 String msgTime(String timestamp) {
  DateTime now = DateTime.now();
  DateTime messageTimeUtc = DateTime.parse(timestamp);
  DateTime messageTimeIndian = messageTimeUtc.add(const Duration(hours: 5, minutes: 30));

  if (now.year == messageTimeIndian.year &&
      now.month == messageTimeIndian.month &&
      now.day == messageTimeIndian.day) {
    return DateFormat.jm().format(messageTimeIndian);
  } else if (now.year == messageTimeIndian.year &&
      now.month == messageTimeIndian.month &&
      now.day - messageTimeIndian.day == 1) {
    return "Yesterday";
  } else {
    return DateFormat.yMEd().format(messageTimeIndian);
  }
}
}
