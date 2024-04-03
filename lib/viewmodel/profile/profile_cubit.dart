import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/viewmodel/profile/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(InitialState());

  Future getProfileDetail(bool googleLogin) async {
    emit(LoadingState());
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      if (googleLogin) {
        emit(
          ProfileSuccessState(
            UserDetail(
              uid: currentUser.uid,
              docId: "",
              username: currentUser.displayName ?? "username",
              phone: "",
              email: currentUser.email ?? "email",
              location: "",
              profilePictureUrl: currentUser.photoURL ?? "",
              role: "jamaah",
            ),
          ),
        );
      } else {
        var collection = FirebaseFirestore.instance.collection("user");
        try {
          await collection.doc(currentUser.uid).get().then(
            (DocumentSnapshot querySnapshot) {
              if (querySnapshot.exists && querySnapshot.data() != null) {
                UserDetail userData = UserDetail.fromFirestore(
                    querySnapshot.data() as Map<String, dynamic>);

                emit(ProfileSuccessState(userData));
              }
            },
            onError: (e) => emit(
              ProfileErrorState(e.toString()),
            ),
          );
        } catch (e) {
          emit(ProfileErrorState(e.toString()));
        }
      }
    } else {
      emit(const ProfileErrorState("Invalid User"));
    }
  }

  Future logout() async {
    emit(LoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutErrorState(e.toString()));
    }
  }
}
