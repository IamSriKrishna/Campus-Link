abstract class MessageEvent {}

class ConnectSocketMessageEvent extends MessageEvent {}

class GetMessageEvent extends MessageEvent {
  final String chatId;

  GetMessageEvent({required this.chatId});
}

class SendMessageEvent extends MessageEvent {
  final String content;
  final String chatId;
  final String receiver;

  SendMessageEvent({
    required this.content,
    required this.chatId,
    required this.receiver,
  });
}

class ClearMessageEvent extends MessageEvent {}

class UserOnlineStatusEvent extends MessageEvent {
  final String userId;
  final bool isOnline;

  UserOnlineStatusEvent({required this.userId, required this.isOnline});
}

class UserTypingStatusEvent extends MessageEvent {
  final String userId;
  final bool isTyping;

  UserTypingStatusEvent({required this.userId, required this.isTyping});
}