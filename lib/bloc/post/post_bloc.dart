import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/post/post_event.dart';
import 'package:campuslink/bloc/post/post_state.dart';
import 'package:campuslink/controller/post/post_controller.dart';
import 'package:get_storage/get_storage.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostController _postController;
  PostBloc(this._postController) : super(InitialPostState()) {
    on<ReadPostEvent>((event, emit) async {
      try {
        final postModel = await _postController.readPostData();
        emit(ReadPostState(postModel: postModel));
      } catch (e) {
        emit(FailedPostState(error: e.toString()));
      }
    });
    on<LikePostEvent>((event, emit) async {
      try {
        final prefs = GetStorage();
        final userId = prefs.read("userId");
        if (userId == null) {
          throw Exception('User ID not found');
        }

        final success = await _postController.likePost(
            studentId: userId, postId: event.postId);

        if (success) {
          // Fetch updated post data
          final postModel = await _postController.readPostData();
          emit(ReadPostState(postModel: postModel));
        } else {
          emit(FailedPostState(error: 'Failed to like post'));
        }
      } catch (e) {
        emit(FailedPostState(error: e.toString()));
      }
    });

  }
}
