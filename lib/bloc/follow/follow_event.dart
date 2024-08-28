abstract class FollowEvent {}

class DoFollowEvent extends FollowEvent {
  final String followerId;
  final String followeeId;
  DoFollowEvent({required this.followeeId, required this.followerId});
}

class DoUnFollowEvent extends FollowEvent {
  final String followerId;
  final String followeeId;
  DoUnFollowEvent({required this.followeeId, required this.followerId});
}
