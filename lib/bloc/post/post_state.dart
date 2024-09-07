import 'package:campuslink/model/post/post.dart';

abstract class PostState {}

class InitialPostState extends PostState {}

class LoadingPostState extends PostState {}

class InitialSuccessPostState extends PostState {}

class SuccessPostState extends PostState {}

class FailedPostState extends PostState {
  final String error;
  FailedPostState({required this.error});
}

class ReadPostState extends PostState {
  final PostModel postModel;
  ReadPostState({required this.postModel});
}

class LikePostState extends PostState {}
