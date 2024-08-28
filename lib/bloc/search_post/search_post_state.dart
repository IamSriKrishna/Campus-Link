import 'package:campuslink/model/post/post.dart';

abstract class SearchPostState {}

class InitialSearchPostState extends SearchPostState {}

class LoadingSearchPostState extends SearchPostState {}

class InitialSuccessSearchPostState extends SearchPostState {}

class SuccessSearchPostState extends SearchPostState {}

class FailedSearchPostState extends SearchPostState {
  final String error;
  FailedSearchPostState({required this.error});
}

class ReadSearchPostState extends SearchPostState {
  final PostModel postModel;
  ReadSearchPostState({required this.postModel});
}