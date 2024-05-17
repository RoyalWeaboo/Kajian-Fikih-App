import 'package:equatable/equatable.dart';

class LikePostState extends Equatable {
  const LikePostState();

  @override
  List<Object> get props => [];
}

class LikePostInitialState extends LikePostState {}

class LikePostLoadingState extends LikePostState {}

class LikePostSuccessState extends LikePostState {}

class GetLikePostStatusSuccessState extends LikePostState {
  final bool isLiked;

  const GetLikePostStatusSuccessState(this.isLiked);

  @override
  List<Object> get props => [isLiked];
}

class LikePostErrorState extends LikePostState {
  final String errorMessage;

  const LikePostErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
