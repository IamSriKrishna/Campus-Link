import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/message/message_event.dart';
import 'package:campuslink/bloc/message/message_state.dart';
import 'package:campuslink/controller/message/message_controller.dart';
import 'package:campuslink/model/message/message.dart';
import 'package:get_storage/get_storage.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageController _messageController;

  MessageBloc(this._messageController) : super(InitialMessageState()) {
    on<GetMessageEvent>((event, emit) async {
      try {
        final prefs = GetStorage();
        final token = prefs.read("token");
        if (token == null) {
          throw Exception('Token not found');
        }
        final messageModel = await _messageController.getMessages(
          token: token,
          chatId: event.chatId,
        );
        emit(GetMessageState(messageModel: messageModel));
      } catch (e) {
        emit(FailedMessageState(error: e.toString()));
      }
    });

    on<SendMessageEvent>((event, emit) async {
      try {
        final prefs = GetStorage();
        final token = prefs.read("token");
        if (token == null) {
          throw Exception('Token not found');
        }
        final success = await _messageController.createMessage(
          token: token,
          chatId: event.chatId,
          content: event.content,
          receiver: event.receiver,
        );
        // Optimistic UI update
        final temporaryMessage = Message(
          id: UniqueKey().toString(),
          sender: Sender(
              id: "user_id",
              name: "username",
              rollno: "",
              dp: "",
              department: "",
              certified: false,
              fcmtoken: ""),
          content: event.content,
          receiver: event.receiver,
          chat: Chat(
              id: event.chatId,
              chatName: "",
              isGroupChat: false,
              users: [],
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              v: 0),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          readBy: [],
          v: 0,
        );

        // Emit temporary message
        var currentState = (state as GetMessageState).messageModel;
        currentState.chat.add(temporaryMessage);
        emit(GetMessageState(messageModel: currentState));

        if (success) {
          emit(SuccessMessageState());
          add(GetMessageEvent(chatId: event.chatId));
        }
      } catch (e) {
        emit(FailedMessageState(error: e.toString()));
      }
    });

    on<ClearMessageEvent>((event, emit) {
      emit(ExitMessageState());
    });
    // Handle online status updates
    on<UserOnlineStatusEvent>((event, emit) async {
      emit(OnlineMessageState(isOnline: event.isOnline));

    });

    // Handle typing status updates
    on<UserTypingStatusEvent>((event, emit) async {
      emit(TextingMessageState(texting: event.isTyping));
    });
  }
}
