import 'package:equatable/equatable.dart';

class SavePostState extends Equatable {
  const SavePostState();

  @override
  List<Object> get props => [];
}

class SavePostInitialState extends SavePostState {}

class SavePostLoadingState extends SavePostState {}

class SavePostSuccessState extends SavePostState {}

class GetSavePostStatusSuccessState extends SavePostState {
  final bool isSaved;

  const GetSavePostStatusSuccessState(this.isSaved);

  @override
  List<Object> get props => [isSaved];
}

class SavePostErrorState extends SavePostState {
  final String errorMessage;

  const SavePostErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
