import 'dart:math';
import 'package:flutter/material.dart';
import 'package:campuslink/bloc/auth/auth_bloc.dart';
import 'package:campuslink/bloc/auth/auth_event.dart';
import 'package:campuslink/bloc/chat/chat_bloc.dart';
import 'package:campuslink/bloc/chat/chat_event.dart';
import 'package:campuslink/bloc/post/post_bloc.dart';
import 'package:campuslink/bloc/post/post_event.dart';
import 'package:campuslink/bloc/search_post/search_post_bloc.dart';
import 'package:campuslink/bloc/search_post/search_post_event.dart';
import 'package:campuslink/model/post/post.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class HelperFunctions {
  static PostModel shufflePosts(PostModel postModel) {
    final random = Random();
    final shuffledData = postModel.data.toList()..shuffle(random);
    return PostModel(data: shuffledData);
  }

  static Future<void> refreshContentOfReadPost(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<PostBloc>().add(ReadPostEvent());
  }

  static Future<void> refreshContentOfSearchPostWithShuffle(
      BuildContext context) async {
    if (context.mounted) {
      await Future.delayed(const Duration(seconds: 2));
      context.read<SearchPostBloc>().add(ShuffleSearchPostEvent());
    }
  }

  static Future<void> refreshMyProfile(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    Provider.of<AuthProvider>(context, listen: false).refreshStudentData();
    context.read<AuthBloc>().add(GetStudentByIdEvent());
  }

  static Future<void> refreshChat(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    context.read<ChatBloc>().add(GetChatEvent());
  }
  // static Future<void> refreshCredit(BuildContext context) async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   context.read<AuthBloc>().add(GetStudentByIdEvent());
  // }
}
