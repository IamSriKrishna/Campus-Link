import 'package:campuslink/handler/messenger/messenger_handler.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/bloc/fcm/fcm_bloc.dart';
import 'package:campuslink/bloc/fcm/fcm_event.dart';
import 'package:campuslink/bloc/message/message_bloc.dart';
import 'package:campuslink/bloc/message/message_event.dart';
import 'package:campuslink/handler/socket/message_socket.dart';
import 'package:campuslink/widget/message/message_widget.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/widget/notifications/notification_handler.dart';
import 'package:provider/provider.dart';

class MessageScreen extends StatefulWidget {
  final String chatId;
  final String name;
  final String dp;
  final String id;
  final String token;

  const MessageScreen({
    super.key,
    required this.chatId,
    required this.token,
    required this.name,
    required this.dp,
    required this.id,
  });

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    SocketService.joinChat(widget.chatId,context);
    super.initState();
    NotificationHandler.setOnChatScreen(true);
    _initializeSocketAndMessages();
  }

  void _initializeSocketAndMessages() {
    context.read<MessageBloc>().add(GetMessageEvent(chatId: widget.chatId));
  }

  void _sendMessage() {
    final student = Provider.of<AuthProvider>(context, listen: false).student!;
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      SocketService.sendMessage(widget.chatId, message, student.id);
      context.read<FcmBloc>().add(SendFcmEvent(
          title: student.name, body: message, token: widget.token));
      context.read<MessageBloc>().add(SendMessageEvent(
            chatId: widget.chatId,
            receiver: widget.id,
            content: message,
          ));
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        return context.read<MessageBloc>().add(ClearMessageEvent());
      },
      child: MessageBlocListener.build(
        chatId: widget.chatId,
        child: Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              MessageWidget.sliverAppBar(name: widget.name, dp: widget.dp),
              MessageWidget.message(
                  scrollController: _scrollController, id: widget.id),
              MessageWidget.sendMessage(
                  context: context,
                  onTap: _sendMessage,
                  controller: _messageController),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    NotificationHandler.setOnChatScreen(false);
    _scrollController.dispose();
    _messageController.dispose();
    SocketService.leaveChat(widget.chatId);
    super.dispose();
  }
}
