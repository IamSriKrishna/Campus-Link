// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/bloc/message/message_bloc.dart';
import 'package:campuslink/bloc/message/message_event.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static io.Socket? socket;

  static void connect(BuildContext context) {
    final prefs = GetStorage();
    final userId = prefs.read("userId");
    if (userId == null) {
      throw Exception('User ID not found');
    }

    socket = io.io(
      Url.baseurl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .setReconnectionAttempts(5)
          .setReconnectionDelay(2000)
          .build(),
    );

    socket?.onConnect((_) {
      print("$userId connected to socket");
      setupUser(userId);
    });

    socket?.onDisconnect((_) {
      print('Disconnected from socket server');
    });

    socket?.on('online-user', (userId) {
      print("Received online-user event for $userId");
      context
          .read<MessageBloc>()
          .add(UserOnlineStatusEvent(userId: userId, isOnline: true));
    });

    socket?.on('typing', (userId) {
      context
          .read<MessageBloc>()
          .add(UserTypingStatusEvent(userId: userId, isTyping: true));
    });

    socket?.on('stop typing', (userId) {
      context
          .read<MessageBloc>()
          .add(UserTypingStatusEvent(userId: userId, isTyping: false));
    });
  }
  
  static void setupUser(String userId) {
    socket?.emit('setup', userId);
  }

  static void joinChat(String chatId, BuildContext context) {
    print('Join chat:${chatId}');
    socket?.emit('join chat', chatId);
    socket?.on('message received', (data) {
      context.read<MessageBloc>().add(GetMessageEvent(chatId: chatId));
    });
  }

  static void leaveChat(String chatId) {
    print('Exit chat:${chatId}');
    if (socket != null && socket!.connected) {
      socket?.emit('setupOff', chatId);
    }
  }

  static void sendMessage(String chatId, String message, String senderId) {
    if (socket != null && socket!.connected) {
      socket?.emit('new message', {
        'chat': {'_id': chatId},
        'content': message,
        'sender': {'_id': senderId}
      });
    }
  }

  static void disconnect() {
    if (socket != null) {
      socket?.disconnect();
      socket = null;
    }
  }
}
