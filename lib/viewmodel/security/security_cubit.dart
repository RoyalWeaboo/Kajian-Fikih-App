import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/viewmodel/security/security_state.dart';

class SecurityCubit extends Cubit<SecurityState> {
  SecurityCubit() : super(SecurityInitialState());

  Future resetPassword(String email) async {
    try {
      emit(SecurityLoadingState());

      FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      emit(SecuritySuccessState());
    } catch (e) {
      emit(SecurityErrorState(e.toString()));
    }
  }

  Future updatePassword(String newPassword) async {
    try {
      emit(SecurityLoadingState());
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword).then((_) {
          emit(SecuritySuccessState());
        }).catchError((error) {
          emit(SecurityErrorState(error.toString()));
        });
      }
    } catch (e) {
      emit(SecurityErrorState(e.toString()));
    }
  }
}
