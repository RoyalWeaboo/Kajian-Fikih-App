import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/viewmodel/follow_user/follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  FollowCubit() : super(FollowInitialState());

  Future getFollowStatus(String uid) async {
    emit(FollowLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        bool followingStatus = false;
        final followedUserCollection = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection("followedUser")
            .doc(uid)
            .get();
        if (followedUserCollection.exists) {
          followingStatus = true;
        } else {
          followingStatus = false;
        }
        emit(GetFollowStatusSuccessState(followingStatus));
      }
    } catch (e) {
      emit(FollowErrorState(e.toString()));
    }
  }

  Future followUser(String followedUid) async {
    emit(FollowLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        UserDetail userData = UserDetail(
            uid: "",
            username: "",
            phone: "",
            email: "",
            location: "",
            profilePictureUrl: "",
            role: "");

        final followedUserCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('followedUser')
            .doc(followedUid);

        await FirebaseFirestore.instance
            .collection('user')
            .doc(followedUid)
            .get()
            .then(
          (DocumentSnapshot querySnapshot) {
            if (querySnapshot.exists && querySnapshot.data() != null) {
              userData = UserDetail.fromFirestore(
                  querySnapshot.data() as Map<String, dynamic>);
            }
          },
        );

        final followingStatus = await followedUserCollection.get();

        if (followingStatus.exists) {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(followedUid)
              .update(
            {
              'followerCount': userData.followerCount! - 1,
            },
          );
          //delete from sub collection (unfollow)
          followedUserCollection.delete();
        } else {
          await FirebaseFirestore.instance
              .collection('user')
              .doc(followedUid)
              .update(
            {
              'followerCount': (userData.followerCount ?? 0) + 1,
            },
          );
          //save user to sub collection followedUser
          await FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .collection('followedUser')
              .doc(followedUid)
              .set(userData.toFirestore());
        }
        emit(
          FollowSuccessState(),
        );
      }
    } catch (e) {
      emit(
        FollowErrorState(
          e.toString(),
        ),
      );
    }
  }
}
