import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/user_detail.dart';

class UserDetailState extends Equatable {
  const UserDetailState();

  @override
  List<Object?> get props => [];
}

class UserDetailInitialState extends UserDetailState {}

class UserDetailLoadingState extends UserDetailState {}

class UserDetailSuccessState extends UserDetailState {
  final UserDetail userData;

  const UserDetailSuccessState(this.userData);
  @override
  List<Object> get props => [userData];
}

class UserDetailErrorState extends UserDetailState {
  final String errorMessage;

  const UserDetailErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
