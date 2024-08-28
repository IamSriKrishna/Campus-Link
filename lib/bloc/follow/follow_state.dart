abstract class FollowState {}

class InitialFollowState extends FollowState {}

class LoadingFollowState extends FollowState {}

// Separate states for follow and unfollow success
class SuccessFollowState extends FollowState {}

class SuccessUnfollowState extends FollowState {}

class FailedFollowState extends FollowState {
  final String error;
  FailedFollowState({required this.error});
}
