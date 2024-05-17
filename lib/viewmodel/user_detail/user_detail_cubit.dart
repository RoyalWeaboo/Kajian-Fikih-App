import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/viewmodel/user_detail/user_detail_state.dart';

class UserDetailCubit extends Cubit<UserDetailState> {
  UserDetailCubit() : super(UserDetailInitialState());

  Future getUserDetail() async {
    emit(UserDetailLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final snapshot = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();
        if (snapshot.exists) {
          emit(UserDetailSuccessState(
              UserDetail.fromFirestore(snapshot.data()!)));
        } else {
          emit(const UserDetailErrorState("User not found"));
        }
      } else {
        emit(const UserDetailErrorState("403 - Unauthorized"));
      }
    } catch (e) {
      emit(UserDetailErrorState(e.toString()));
    }
  }
}
