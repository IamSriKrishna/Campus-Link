
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/follow/follow_event.dart';
import 'package:campuslink/bloc/follow/follow_state.dart';
import 'package:campuslink/controller/follow/follow_controller.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final FollowController _followController;

  FollowBloc(this._followController) : super(InitialFollowState()) {
    on<DoFollowEvent>((event, emit) async {
      emit(LoadingFollowState());
      try {
        final follow = await _followController.addFollow(
            event.followerId, event.followeeId);
        if (follow) {
          emit(SuccessFollowState());
        }
      } catch (e) {
        emit(FailedFollowState(error: e.toString()));
      }
    });

    on<DoUnFollowEvent>((event, emit) async {
      emit(LoadingFollowState());
      try {
        final unfollow = await _followController.removeFollow(
            event.followerId, event.followeeId);
        if (unfollow) {
          emit(SuccessUnfollowState()); 
        }
      } catch (e) {
        emit(FailedFollowState(error: e.toString()));
      }
    });
  }
}
