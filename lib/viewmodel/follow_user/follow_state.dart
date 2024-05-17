import 'package:equatable/equatable.dart';

class FollowState extends Equatable {
  const FollowState();

  @override
  List<Object?> get props => [];
}

class FollowInitialState extends FollowState {}

class FollowLoadingState extends FollowState {}

class GetFollowStatusSuccessState extends FollowState {
  final bool isFollowed;

  const GetFollowStatusSuccessState(this.isFollowed);

  @override
  List<Object?> get props => [isFollowed];
}

class FollowSuccessState extends FollowState {}

class FollowErrorState extends FollowState {
  final String errorMessage;

  const FollowErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
