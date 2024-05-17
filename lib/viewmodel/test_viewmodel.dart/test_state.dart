//THIS VIEWMODEL IS FOR DEVELOPMENT PURPOSE ONLYimport 'package:equatable/equatable.dart';

import 'package:equatable/equatable.dart';

class TestViewModelState extends Equatable {
  const TestViewModelState();

  @override
  List<Object?> get props => [];
}

class TestViewModelInitialState extends TestViewModelState {}

class TestViewModelLoadingState extends TestViewModelState {}

class TestViewModelSuccessState extends TestViewModelState {}

class TestViewModelErrorState extends TestViewModelState {
  final String errorMessage;

  const TestViewModelErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
