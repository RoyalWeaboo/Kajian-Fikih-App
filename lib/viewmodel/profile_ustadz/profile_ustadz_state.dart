import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/model/ustadz_profile_detail.dart';

abstract class ProfileUstadzState extends Equatable {
  const ProfileUstadzState();

  @override
  List<Object> get props => [];
}

class ProfileUstadzInitialState extends ProfileUstadzState {}

class ProfileUstadzLoadingState extends ProfileUstadzState {}

class ProfileUstadzSuccessState extends ProfileUstadzState {
  final UserDetail userDetail;
  final UstadzProfileDetail? ustadzProfileDetail;

  const ProfileUstadzSuccessState(
      {required this.userDetail, this.ustadzProfileDetail});
  @override
  List<Object> get props => [userDetail, ustadzProfileDetail ?? []];
}

class ProfileUstadzUpdateSuccessState extends ProfileUstadzState {}

class ProfileUstadzErrorState extends ProfileUstadzState {
  final String errorMessage;

  const ProfileUstadzErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}

class ProfileUstadzLogoutSuccessState extends ProfileUstadzState {}

class ProfileUstadzLogoutErrorState extends ProfileUstadzState {
  final String errorMessage;

  const ProfileUstadzLogoutErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
