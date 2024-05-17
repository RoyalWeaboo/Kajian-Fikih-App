import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/user_detail.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class InitialState extends ProfileState {}

class LoadingState extends ProfileState {}

class ProfileSuccessState extends ProfileState {
  final UserDetail userDetail;

  const ProfileSuccessState({required this.userDetail});
  @override
  List<Object> get props => [userDetail];
}

class ProfileErrorState extends ProfileState {
  final String errorMessage;

  const ProfileErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class LogoutSuccessState extends ProfileState {}

class LogoutErrorState extends ProfileState {
  final String errorMessage;

  const LogoutErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
