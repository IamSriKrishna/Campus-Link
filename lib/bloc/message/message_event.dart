// message_event.dart

import 'package:campuslink/model/message/message.dart';

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

class IncomingMessageEvent extends MessageEvent {
  final Message message;
  
  IncomingMessageEvent({required this.message});
}