import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/comment.dart';

class PostCommentState extends Equatable {
  const PostCommentState();

  @override
  List<Object> get props => [];
}

class PostCommentInitialState extends PostCommentState {}

class PostCommentLoadingState extends PostCommentState {}

class GetPostCommentSuccessState extends PostCommentState {
  final List<PostComment> postCommentResponse;

  const GetPostCommentSuccessState(this.postCommentResponse);

  @override
  List<Object> get props => [postCommentResponse];
}

class PostCommentErrorState extends PostCommentState {
  final String errorMessage;

  const PostCommentErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
