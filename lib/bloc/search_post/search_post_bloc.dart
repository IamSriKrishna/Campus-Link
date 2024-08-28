import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:campuslink/bloc/search_post/search_post_event.dart';
import 'package:campuslink/bloc/search_post/search_post_state.dart';
import 'package:campuslink/controller/post/post_controller.dart';
import 'package:campuslink/widget/components/helper_functions.dart';

class SearchPostBloc extends Bloc<SearchPostEvent, SearchPostState> {
  final PostController _postController;
  SearchPostBloc(this._postController) : super(InitialSearchPostState()) {
    on<ReadSearchPostEvent>((event, emit) async {
      emit(LoadingSearchPostState());
      try {
        final postModel = await _postController.readPostData();
        emit(ReadSearchPostState(postModel: postModel));
      } catch (e) {
        emit(FailedSearchPostState(error: e.toString()));
      }
    });

    on<ShuffleSearchPostEvent>((event, emit)async {
      emit(LoadingSearchPostState());
      try {
        final currentState =  await _postController.readPostData();
        final shuffledPosts =
            HelperFunctions.shufflePosts(currentState);
        emit(ReadSearchPostState(postModel: shuffledPosts));
      } catch (e) {
        emit(FailedSearchPostState(error: e.toString()));
      }
    });
  }
}
