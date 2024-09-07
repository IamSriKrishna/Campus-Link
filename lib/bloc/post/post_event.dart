abstract class PostEvent {}

class ReadPostEvent extends PostEvent {}

class LoadMorePostEvent extends PostEvent {}

class LikePostEvent extends PostEvent {
  final String postId;
  LikePostEvent({required this.postId});
}

