import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/model/post.dart';

class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

//online post state
class PostInitialState extends PostState {}

class PostLoadingState extends PostState {}

class PostSuccessState extends PostState {
  final List<Post> postResponse;
  final List<Post> followedUserPostResponse;

  const PostSuccessState(this.postResponse, this.followedUserPostResponse);

  @override
  List<Object> get props => [postResponse, followedUserPostResponse];
}

class PostDetailSuccessState extends PostState {
  final Post postDetailResponse;

  const PostDetailSuccessState(this.postDetailResponse);

  @override
  List<Object> get props => [postDetailResponse];
}

class CreatePostSuccessState extends PostState {}

//offline events state
class OfflineEventSuccessState extends PostState {
  final List<OfflineEvent> offlineEventResponse;

  const OfflineEventSuccessState(this.offlineEventResponse);

  @override
  List<Object> get props => [offlineEventResponse];
}

class CreateOfflineEventSuccessState extends PostState {}

class PostErrorState extends PostState {
  final String errorMessage;

  const PostErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
