import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/post.dart';

class LikedPostState extends Equatable {
  const LikedPostState();

  @override
  List<Object?> get props => [];
}

class LikedPostInitialState extends LikedPostState {}

class LikedPostLoadingState extends LikedPostState {}

class LikedPostSuccessState extends LikedPostState {
  final List<Post> postResponse;

  const LikedPostSuccessState(this.postResponse);

  @override
  List<Object> get props => [postResponse];
}

class LikedPostErrorState extends LikedPostState {
  final String errorMessage;

  const LikedPostErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
