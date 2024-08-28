import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/chat/chat_bloc.dart';
import 'package:campuslink/bloc/chat/chat_event.dart';
import 'package:get/get.dart';
import 'package:campuslink/bloc/message/message_bloc.dart';
import 'package:campuslink/bloc/message/message_state.dart';

class MessageBlocListener {
  static Widget build({required Widget child, required String chatId}) {
    return BlocListener<MessageBloc, MessageState>(
      listener: (context, state) {
        if (state is ExitMessageState) {
          context.read<ChatBloc>().add(GetChatEvent());
          Get.back();
        }
        if (state is FailedMessageState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to send message: ${state.error}')),
          );
        }
      },
      child: child,
    );
  }
}
