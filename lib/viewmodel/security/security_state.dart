import 'package:equatable/equatable.dart';

class SecurityState extends Equatable {
  const SecurityState();

  @override
  List<Object?> get props => [];
}

class SecurityInitialState extends SecurityState {}

class SecurityLoadingState extends SecurityState {}

class SecuritySuccessState extends SecurityState {}

class SecurityErrorState extends SecurityState {
  final String errorMessage;

  const SecurityErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
