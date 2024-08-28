import 'package:campuslink/model/chat/chat.dart';

abstract class ChatState {}

class InitialChatState extends ChatState {}

class LoadingChatState extends ChatState {}

class InitialSuccessChatState extends ChatState {}

class ExitChatState extends ChatState {}
class SuccessChatState extends ChatState {
  final String chatId; // Add this field

  SuccessChatState({required this.chatId});
}

class FailedChatState extends ChatState {
  final String error;
  FailedChatState({required this.error});
}

class GetChatState extends ChatState {
  final ChatModel chatModel;
  GetChatState({required this.chatModel});
}

