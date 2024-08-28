import 'package:dio/dio.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/db/message_database.dart';
import 'package:campuslink/model/message/message.dart';

class MessageController {
  final Dio _dio = Dio();
  final MessageDatabaseHelper _messageDatabaseHelper = MessageDatabaseHelper();
  //create a fresh chat
  Future<bool> createMessage(
      {required String content,
      required String chatId,
      required String receiver,
      required String token}) async {
    try {
      final response = await _dio.post(
        Url.createMessage,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token
        }),
        data: {
          'content': content,
          'chatId': chatId,
          'receiver': receiver,
        },
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<MessageModel> getMessages(
      {required String token, required String chatId}) async {
    Map<String, dynamic> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'x-auth-token': token
    };
    try {
      var response = await _dio.get(
        "${Url.getMessage}/$chatId",
        options: Options(headers: requestHeaders),
      );
      if (response.statusCode == 200) {
        MessageModel messageModel = _parseJson(response.data);
        await _messageDatabaseHelper.saveMessageModel(messageModel);
        return messageModel;
      } else {
        throw Exception("Couldn't load chats");
      }
    } catch (e) {
      MessageModel? messageModel =
          await _messageDatabaseHelper.getMessageModel();
      if (messageModel != null) {
        return messageModel;
      } else {
        throw Exception('Failed to load data and no local data available');
      }
    }
  }

  MessageModel _parseJson(Map<String, dynamic> json) =>
      MessageModel.fromJson(json);
}
