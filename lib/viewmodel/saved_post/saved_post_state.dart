import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/post.dart';

class SavedPostState extends Equatable {
  const SavedPostState();

  @override
  List<Object?> get props => [];
}

class SavedPostInitialState extends SavedPostState {}

class SavedPostLoadingState extends SavedPostState {}

class SavedPostSuccessState extends SavedPostState {
  final List<Post> postResponse;

  const SavedPostSuccessState(this.postResponse);

  @override
  List<Object> get props => [postResponse];
}

class SavedPostErrorState extends SavedPostState {
  final String errorMessage;

  const SavedPostErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
