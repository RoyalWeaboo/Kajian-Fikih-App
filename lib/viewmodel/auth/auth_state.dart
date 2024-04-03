import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kajian_fikih/model/user_detail.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class InitialState extends AuthState {}

class LoadingState extends AuthState {}

class GoogleLoginSuccessState extends AuthState {
  final User user;

  const GoogleLoginSuccessState(this.user);
  @override
  List<Object> get props => [user];
}

class GoogleLoginErrorState extends AuthState {
  final String errorMessage;

  const GoogleLoginErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class LoginSuccessState extends AuthState {
  final UserDetail userDetail;

  const LoginSuccessState(this.userDetail);
  @override
  List<Object> get props => [userDetail];
}

class LoginErrorState extends AuthState {
  final String errorMessage;

  const LoginErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class RegisterSuccessState extends AuthState {
  final UserDetail userDetail;

  const RegisterSuccessState(this.userDetail);
  @override
  List<Object> get props => [userDetail];
}

class RegisterErrorState extends AuthState {
  final String errorMessage;

  const RegisterErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
