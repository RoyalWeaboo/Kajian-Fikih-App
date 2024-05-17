import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/post_notification.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/viewmodel/notification/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitialState());

  Future getAllNotification() async {
    emit(NotificationLoadingState());
    try {
      List<UserDetail> followedUser = [];
      List<PostNotification> notifications = [];
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final followedUserCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('followedUser');

        final snapshot = await followedUserCollection.get();
        for (var doc in snapshot.docs) {
          followedUser.add(UserDetail.fromFirestore(doc.data()));
        }

        if (followedUser.isNotEmpty) {
          for (var users in followedUser) {
            final notifSnapshot = await FirebaseFirestore.instance
                .collection('user')
                .doc(users.uid)
                .collection('notifications')
                .get();

            if (notifSnapshot.docs.isNotEmpty) {
              for (var notif in notifSnapshot.docs) {
                notifications.add(PostNotification.fromFirestore(notif.data()));
              }
              //sort by timestamp
              notifications.sort((a, b) => a.timestamp.compareTo(b.timestamp));
              emit(NotificationSuccessState(notifications));
            } else {
              emit(const NotificationSuccessState([]));
            }
          }
        } else {
          emit(const NotificationSuccessState([]));
        }
      }
    } catch (e) {
      emit(NotificationErrorState(e.toString()));
    }
  }
}
