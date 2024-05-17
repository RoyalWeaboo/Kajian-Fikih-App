import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/model/post.dart';
import 'package:kajian_fikih/model/post_notification.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/viewmodel/post/post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostInitialState());

  Future getAllPost() async {
    emit(PostLoadingState());

    try {
      //to store all recent post
      List<Post> postsList = [];
      //to store all followed user
      List<String> followedUserUids = [];
      //to store all followed user post
      List<Post> followedUserPostList = [];
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        //query for recent post
        final postCollection = FirebaseFirestore.instance.collection('posts');
        QuerySnapshot snapshot = await postCollection.get();
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Post post = Post.fromFirestore(data);
          postsList.add(post);
        }

        //query for all followed user
        final followedUserCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .collection('followedUser');

        final followedUserSnapshot = await followedUserCollection.get();
        for (var doc in followedUserSnapshot.docs) {
          followedUserUids.add(UserDetail.fromFirestore(doc.data()).uid);
        }

        //query all post that posted by followed user
        if (followedUserUids.isNotEmpty) {
          for (var users in followedUserUids) {
            final postSnapshot = await FirebaseFirestore.instance
                .collection('user')
                .doc(users)
                .collection('posts')
                .get();

            if (postSnapshot.docs.isNotEmpty) {
              for (var post in postSnapshot.docs) {
                followedUserPostList.add(Post.fromFirestore(post.data()));
              }
              //sort the post by timestamp
              followedUserPostList
                  .sort((a, b) => a.timestamp.compareTo(b.timestamp));
              emit(PostSuccessState(postsList, followedUserPostList));
            } else {
              emit(PostSuccessState(postsList, const []));
            }
          }
        } else {
          emit(PostSuccessState(postsList, const []));
        }
      } else {
        emit(const PostErrorState("403 Unauthorized - No User Found"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future getPostbyCategory(String category) async {
    emit(PostLoadingState());

    try {
      //to store all recent post
      List<Post> postsList = [];
      //to store all followed user
      List<String> followedUserUids = [];
      //to store all followed user post
      List<Post> followedUserPostList = [];
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        //query for recent post
        final postCollection = FirebaseFirestore.instance.collection('posts');
        QuerySnapshot snapshot =
            await postCollection.where('category', isEqualTo: category).get();
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Post post = Post.fromFirestore(data);
          postsList.add(post);
        }

        //query for all followed user
        final followedUserCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .collection('followedUser');

        final followedUserSnapshot = await followedUserCollection.get();
        for (var doc in followedUserSnapshot.docs) {
          followedUserUids.add(UserDetail.fromFirestore(doc.data()).uid);
        }

        //need to check just search with where from post collection instead of from user collection

        //query all post that posted by followed user
        if (followedUserUids.isNotEmpty) {
          for (var users in followedUserUids) {
            final postSnapshot = await FirebaseFirestore.instance
                .collection('user')
                .doc(users)
                .collection('posts')
                .where('category', isEqualTo: category)
                .get();

            if (postSnapshot.docs.isNotEmpty) {
              for (var post in postSnapshot.docs) {
                followedUserPostList.add(Post.fromFirestore(post.data()));
              }
              //sort the post by timestamp
              followedUserPostList
                  .sort((a, b) => a.timestamp.compareTo(b.timestamp));
              emit(PostSuccessState(postsList, followedUserPostList));
            } else {
              emit(PostSuccessState(postsList, const []));
            }
          }
        } else {
          emit(PostSuccessState(postsList, const []));
        }
      } else {
        emit(const PostErrorState("403 Unauthorized - No User Found"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future getPostbyId(String docId) async {
    emit(PostLoadingState());

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final postCollection = await FirebaseFirestore.instance
            .collection('posts')
            .doc(docId)
            .get();

        if (postCollection.data()!.isNotEmpty) {
          emit(PostDetailSuccessState(
              Post.fromFirestore(postCollection.data()!)));
        } else {
          emit(const PostErrorState("404 - Not Found"));
        }
      } else {
        emit(const PostErrorState("403 Unauthorized - No User Found"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future getEventbyId(String docId) async {
    emit(PostLoadingState());
    List<OfflineEvent> events = [];

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final postCollection = await FirebaseFirestore.instance
            .collection('events')
            .doc(docId)
            .get();

        if (postCollection.data()!.isNotEmpty) {
          events.add(OfflineEvent.fromFirestore(postCollection.data()!));
        } else {
          emit(const PostErrorState("404 - Not Found"));
        }
        emit(OfflineEventSuccessState(events));
      } else {
        emit(const PostErrorState("403 Unauthorized - No User Found"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future addViewCount(String uid, String docId, int currentWatchCount) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(uid)
            .collection('posts')
            .doc(docId)
            .update({'watchCount': currentWatchCount + 1});

        await FirebaseFirestore.instance
            .collection('posts')
            .doc(docId)
            .update({'watchCount': currentWatchCount + 1});
      } else {
        emit(const PostErrorState("403 Unauthorized - No User Found"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future createOnlinePost(
    String postTitle,
    String postContent,
    String category,
    String? youtubeLink,
    XFile? imageFile,
  ) async {
    emit(PostLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('user');

      Timestamp timestamp = Timestamp.fromDate(DateTime.now());

      if (user != null) {
        //user post collection path
        final userPostCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('posts');
        final postId = userPostCollection.doc().id;
        final postCollection = FirebaseFirestore.instance.collection('posts');

        //notification collecton path for following user
        final notificationCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('notifications');
        final notificationId = notificationCollection.doc().id;

        //get user data
        final snapshot = await userCollection.doc(user.uid).get();
        final userData = UserDetail.fromFirestore(snapshot.data()!);
        String imageUrl = "";

        if (imageFile != null) {
          //upload image to firebase storage
          String uniqueFilename =
              DateTime.now().millisecondsSinceEpoch.toString();

          final storageRef = FirebaseStorage.instance;
          Reference dirUpload = storageRef.ref().child('post/${user.uid}');
          Reference storedDir = dirUpload.child(uniqueFilename);
          await storedDir.putFile(File(imageFile.path));

          //get image url from firebase storage
          imageUrl = await storedDir.getDownloadURL();
        }

        if (userData.role == 'ustadz') {
          //data that will be stored
          final postData = Post(
            uid: user.uid,
            docId: postId,
            poster: "Ust. ${userData.username}",
            posterProfileImage: userData.profilePictureUrl,
            postTitle: postTitle,
            postContent: postContent,
            category: category,
            youtubeLink: youtubeLink,
            imageUrl: imageUrl,
            watchCount: 0,
            likeCount: 0,
            timestamp: timestamp,
          );

          //create post in user sub collection, later used for profile page
          await userPostCollection.doc(postId).set(postData.toFirestore());
          //also add in post collection
          await postCollection.doc(postId).set(postData.toFirestore());
          //create notification for user following current user
          final newNotification = PostNotification(
            uid: user.uid,
            docId: notificationId,
            postDocId: postId,
            postType: "online",
            notificationTitle:
                "Ust. ${userData.username} membuat postingan baru.",
            notificationText: postContent,
            timestamp: timestamp,
          );
          await notificationCollection
              .doc(notificationId)
              .set(newNotification.toFirestore());

          emit(CreatePostSuccessState());
        } else {
          emit(const PostErrorState("403 Unauthorized User Role"));
        }
      } else {
        emit(const PostErrorState("403 Unauthorized - Session not found"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  Future createOfflinePost(
    String postTitle,
    String postContent,
    XFile? imageFile,
    String date,
    String category,
    String timeStart,
    String timeEnd,
    String location,
    String locationAddress,
    String? locationUrl,
  ) async {
    emit(PostLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('user');

      Timestamp timestamp = Timestamp.fromDate(DateTime.now());

      if (user != null) {
        //events path
        final userEventCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('events');
        final postId = userEventCollection.doc().id;
        final eventCollection = FirebaseFirestore.instance.collection('events');

        final notificationCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('notifications');
        final notificationId = notificationCollection.doc().id;

        //get user data
        final snapshot = await userCollection.doc(user.uid).get();
        final userData = UserDetail.fromFirestore(snapshot.data()!);

        // Query Firestore to get existing events on the same date
        QuerySnapshot checkDateAvailability = await FirebaseFirestore.instance
            .collection('user')
            .doc(userData.uid)
            .collection('events')
            .where('date', isEqualTo: date)
            .get();

        //if there is no event yet in selected date
        if (checkDateAvailability.docs.isEmpty) {
          String imageUrl = "";

          if (imageFile != null) {
            //upload image to firebase storage
            String uniqueFilename =
                DateTime.now().millisecondsSinceEpoch.toString();

            final storageRef = FirebaseStorage.instance;
            Reference dirUpload = storageRef.ref().child('event/${user.uid}');
            Reference storedDir = dirUpload.child(uniqueFilename);
            await storedDir.putFile(File(imageFile.path));

            //get image url from firebase storage
            imageUrl = await storedDir.getDownloadURL();
          }

          //Data that will be sent to firestore
          final offlineEventData = OfflineEvent(
            uid: user.uid,
            docId: postId,
            poster: "Ust. ${userData.username}",
            posterProfileImage: userData.profilePictureUrl,
            postTitle: postTitle,
            postContent: postContent,
            imageUrl: imageUrl,
            category: category,
            date: date,
            timeStart: timeStart,
            timeEnd: timeEnd,
            location: location,
            locationAddress: locationAddress,
            locationUrl: locationUrl ?? "",
            timestamp: timestamp,
          ).toFirestore();

          if (userData.role == 'ustadz') {
            //create post in user collection, same reason as online post
            await userEventCollection.doc(postId).set(offlineEventData);
            //also create in events collection
            await eventCollection.doc(postId).set(offlineEventData);
            //create notification for user following current user
            final newNotification = PostNotification(
              uid: userData.uid,
              docId: notificationId,
              postDocId: postId,
              postType: "offline",
              notificationTitle:
                  "Ust. ${userData.username} menjadwalkan kajian offline.",
              notificationText:
                  "Ust. ${userData.username} yang anda ikuti akan mengadakan kajian offline pada tanggal $date, cek sekarang !",
              timestamp: timestamp,
            );
            await notificationCollection
                .doc(notificationId)
                .set(newNotification.toFirestore());

            emit(CreateOfflineEventSuccessState());
          } else {
            emit(const PostErrorState("403 Unauthorized User Role"));
          }
        } else {
          emit(PostErrorState("Sudah ada Jadwal Kajian pada Tanggal $date"));
        }
      } else {
        emit(const PostErrorState("403 Unauthorized - Session not found"));
      }
    } catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }

  // Future getAllOfflineEvent() async {
  //   emit(LoadingState());
  //   try {
  //     List<OfflineEvent> eventsList = [];
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       final eventsCollection =
  //           FirebaseFirestore.instance.collection('events');
  //       QuerySnapshot snapshot = await eventsCollection.get();
  //       for (var doc in snapshot.docs) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //         OfflineEvent events = OfflineEvent.fromFirestore(data);
  //         eventsList.add(events);
  //       }
  //       emit(OfflineEventSuccessState(eventsList));
  //     } else {
  //       emit(const PostErrorState("403 Unauthorized - No User Found"));
  //     }
  //   } catch (e) {
  //     emit(PostErrorState(e.toString()));
  //   }
  // }

  // Future getUserOfflineEvent() async {
  //   emit(LoadingState());
  //   try {
  //     List<OfflineEvent> eventsList = [];
  //     final user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       final eventsCollection = FirebaseFirestore.instance
  //           .collection('user')
  //           .doc(user.uid)
  //           .collection('events');
  //       QuerySnapshot snapshot = await eventsCollection.get();
  //       for (var doc in snapshot.docs) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //         OfflineEvent events = OfflineEvent.fromFirestore(data);
  //         eventsList.add(events);
  //       }
  //       emit(OfflineEventSuccessState(eventsList));
  //     } else {
  //       emit(const PostErrorState("403 Unauthorized - No User Found"));
  //     }
  //   } catch (e) {
  //     emit(PostErrorState(e.toString()));
  //   }
  // }
}
