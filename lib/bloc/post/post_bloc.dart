import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/post/post_event.dart';
import 'package:campuslink/bloc/post/post_state.dart';
import 'package:campuslink/controller/post/post_controller.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostController _postController;
  PostBloc(this._postController) : super(InitialPostState()) {
    on<ReadPostEvent>((event, emit) async {
      emit(LoadingPostState());
      try {
        final postModel = await _postController.readPostData();
        emit(ReadPostState(postModel: postModel));
      } catch (e) {
        emit(FailedPostState(error: e.toString()));
      }
    });
    
  }
}
