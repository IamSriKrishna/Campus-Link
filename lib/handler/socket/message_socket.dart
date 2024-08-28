// import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:campuslink/app/url.dart';
import 'package:campuslink/bloc/message/message_bloc.dart';
import 'package:campuslink/bloc/message/message_event.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:campuslink/provider/auth_provider.dart';

class SocketService {
  static io.Socket? socket;

  static void connect(BuildContext context, String chatId,) {
    final student = Provider.of<AuthProvider>(context, listen: false).student!;

    socket = io.io(
      Url.baseurl,
      io.OptionBuilder().setTransports(['websocket']).build(),
      
    );

    socket?.onConnect((_) {
      //print('Connected to socket server');
      setupUser(student.id);
      joinChat(chatId);
    });

    socket?.on('message received', (data) {
      //print('Message received: $data');
      context.read<MessageBloc>().add(GetMessageEvent(chatId:chatId));
    });

    socket?.onDisconnect((_) {
      //print('Disconnected from socket server');
    });
  }

  static void setupUser(String userId) {
    socket?.emit('setup', userId);
  }

  static void joinChat(String chatId) {
    socket?.emit('join chat', chatId);
  }

  static void sendMessage(String chatId, String message, String senderId) {
    if (socket != null && socket!.connected) {
      socket?.emit('new message', {
        'chat': {'_id': chatId},
        'content': message,
        'sender': {'_id': senderId}
      });
    } else {
      //print("Socket not connected");
    }
  }

  static void disconnect() {
    socket?.disconnect();
  }
}
