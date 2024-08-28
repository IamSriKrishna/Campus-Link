import 'package:dio/dio.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/db/chat_database.dart';
import 'package:campuslink/model/chat/chat.dart';

class ChatController {
  final Dio _dio = Dio();
  final ChatDatabaseHelper _chatDatabaseHelper = ChatDatabaseHelper();
  Future<Map<String, dynamic>> createChat({required String id, required String token}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token
    };
    try {
      var response = await _dio.post(Url.createChat,
          options: Options(headers: requestHeaders), data: {"userId": id});

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to create chat');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ChatModel> getConversations({required String token}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token
    };

    try {
      var response = await _dio.get(
        Url.getChat,
        options: Options(headers: requestHeaders),
      );
      if (response.statusCode == 200) {
        ChatModel chatModel = _parseJson(response.data);
        await _chatDatabaseHelper.saveChatModel(chatModel);
        return chatModel;
      } else {
        throw Exception("Couldn't load chats");
      }
    } catch (e) {
      ChatModel? chatModel = await _chatDatabaseHelper.getChatModel();
      if (chatModel != null) {
        return chatModel;
      } else {
        throw Exception('Failed to load data and no local data available');
      }
    }
  }
  
  ChatModel _parseJson(Map<String, dynamic> json) => ChatModel.fromJson(json);
}
