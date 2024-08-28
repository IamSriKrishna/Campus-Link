import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/chat/chat_event.dart';
import 'package:campuslink/bloc/chat/chat_state.dart';
import 'package:campuslink/controller/chat/chat_controller.dart';
import 'package:campuslink/handler/socket/socket_handler.dart';
import 'package:get_storage/get_storage.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatController _chatController;
  final WebSocketService _webSocketService;
  ChatBloc(this._chatController, this._webSocketService)
      : super(InitialChatState()) {
    _webSocketService.connect();
    on<GetChatEvent>((event, emit) async {
      try {
        final prefs = GetStorage();
        final token = prefs.read("token");
        if (token == null) {
          throw Exception('token not found');
        }
        final success = await _chatController.getConversations(token: token);
        emit(GetChatState(chatModel: success));
      } catch (e) {
        emit(FailedChatState(error: e.toString()));
      }
    });

    on<CreateChatEvent>((event, emit) async {
      try {
        emit(LoadingChatState());
        final prefs = GetStorage();
        final token = prefs.read("token");
        if (token == null) {
          throw Exception('Token not found');
        }

        // Perform chat creation and get the result, which may include chat details
        final result =
            await _chatController.createChat(token: token, id: event.userId);

        // Assuming result contains chatId or other details
        final chatId =
            result['_id']; // Adapt based on your actual result structure
        if (chatId != null) {
          emit(SuccessChatState(chatId: chatId));
        } else {
          emit(FailedChatState(error: 'Failed to create chat'));
        }
      } catch (e) {
        debugPrint(e.toString());
        emit(FailedChatState(error: e.toString()));
      }
    });

    _webSocketService.getStream().listen((data) {
      add(GetChatEvent());
    });

    on<ClearChatEvent>((event, emit) {
      _webSocketService.disconnect();
      emit(ExitChatState());
    });
  }
}
