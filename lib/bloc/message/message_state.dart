import 'package:campuslink/model/message/message.dart';

abstract class MessageState {}

class InitialMessageState extends MessageState {}

class LoadingMessageState extends MessageState {}

class InitialSuccessMessageState extends MessageState {}

class SuccessMessageState extends MessageState {}

class FailedMessageState extends MessageState {
  final String error;
  FailedMessageState({required this.error});
}

class GetMessageState extends MessageState {
  final MessageModel messageModel;
  GetMessageState({required this.messageModel});
}

class ExitMessageState extends MessageState {}

class OnlineMessageState extends MessageState {
  final bool isOnline;
  OnlineMessageState({required this.isOnline});
}

class TextingMessageState extends MessageState {
  final bool texting;
  TextingMessageState({required this.texting});
}
