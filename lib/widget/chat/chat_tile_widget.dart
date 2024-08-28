import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/widget/components/components.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatTile extends StatelessWidget {
  final String dp;
  final String name;
  final String latestMessage;
  final DateTime time;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.dp,
    required this.name,
    required this.latestMessage,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(30.sw),
        child: CachedNetworkImage(
            fit: BoxFit.cover, height: 55, width: 55, imageUrl: dp),
      ),
      title: Components.googleFonts(text: name),
      subtitle: Components.googleFonts(
        overflow: TextOverflow.ellipsis,
          text: latestMessage.isEmpty
              ? "start a new chat"
              : "msg:$latestMessage"),
      trailing: Components.googleFonts(text: timeago.format(time)),
      onTap: onTap,
    );
  }
}
