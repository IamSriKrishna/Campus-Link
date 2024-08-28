import 'package:flutter/material.dart';
import 'package:campuslink/widget/chat/chat_widget.dart';
import 'package:campuslink/widget/components/helper_functions.dart';

class ChatScreen extends StatefulWidget {
  final void Function() onTap;
  const ChatScreen({super.key, required this.onTap});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool canPop = false;
  @override
  Widget build(BuildContext context) {
    return PopScope<Object?>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }

        return widget.onTap();
      },
      child: RefreshIndicator(
        onRefresh: () => HelperFunctions.refreshChat(context),
        child: Scaffold(
          key: const PageStorageKey<String>("Chat"),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              ChatWidget.sliverAppBar(
                  onTap: () => widget.onTap(), context: context),
              ChatWidget.searchField(),
              ChatWidget.chat(context)
            ],
          ),
        ),
      ),
    );
  }
}
