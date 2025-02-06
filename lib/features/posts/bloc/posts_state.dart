part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

abstract class PostsActionState extends PostsState{}


class PostsInitial extends PostsState {}


class PostsFetchingLoadingState extends PostsState{}
class PostsFetchingErrorState extends PostsState{}


class PostFetchingSuccessFulState extends PostsState {
  final List<PostDataUiModel> posts;

  PostFetchingSuccessFulState({
    required this.posts,
  });
}
class PostFetchingFailureState extends PostsState {
  final String error;

  PostFetchingFailureState({required this.error});
}

class PostsAdditionSuccessState extends PostsActionState{}

class PostsAdditionErrorState extends PostsActionState{}

