import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_api_example/features/posts/models/post_data_ui_model.dart';
import 'package:meta/meta.dart';

import '../repos/posts_repo.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddEvent>(postAddEvent); // Fixed event registration
  }

  Future<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());

    try {
      List<PostDataUiModel> posts = await PostsRepo.fetchPosts(); // Fetch posts

      if (posts.isNotEmpty) {
        emit(PostFetchingSuccessFulState(posts: posts));
      } else {
        emit(PostFetchingFailureState(error: 'No posts found'));
      }
    } catch (e) {
      emit(PostFetchingFailureState(error: 'Failed to fetch posts: $e'));
    }
  }

  Future<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
      bool success = await PostsRepo.addPost();
      if(success){
        emit(PostsAdditionSuccessState());
        print(success);
      }else{
        emit(PostsAdditionErrorState());
      }

  }
}
