import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kajian_fikih/model/comment.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/viewmodel/post_comment/post_comment_state.dart';

class PostCommentCubit extends Cubit<PostCommentState> {
  PostCommentCubit() : super(PostCommentInitialState());

  Future createComment({
    required String uid,
    required String postId,
    required String comment,
    XFile? imageFile,
  }) async {
    try {
      emit(PostCommentLoadingState());
      final user = FirebaseAuth.instance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('user');

      final commentCollection = FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments');
      final id = commentCollection.doc().id;
      Timestamp timestamp = Timestamp.fromDate(DateTime.now());

      if (user != null) {
        final data = await userCollection.doc(user.uid).get();
        final userData = UserDetail.fromFirestore(data.data()!);

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

        await commentCollection.doc(id).set(
              PostComment(
                      uid: userData.uid,
                      docId: id,
                      commenter: userData.username,
                      commenterProfileImage: userData.profilePictureUrl,
                      comment: comment,
                      timestamp: timestamp,
                      imageUrl: imageUrl)
                  .toFirestore(),
            );
        emit(PostCommentInitialState());
      } else {
        emit(const PostCommentErrorState(
            "403 Unauthorized - Session not found"));
      }
    } catch (e) {
      emit(PostCommentErrorState(e.toString()));
    }
  }

  // //function to get comment
  // Future getPostComment(
  //   String postId,
  //   String uid,
  // ) async {
  //   emit(PostCommentLoadingState());
  //   try {
  //     List<PostComment> postsCommentList = [];
  //     final user = FirebaseAuth.instance.currentUser;
  //     final commentCollection = FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(uid)
  //         .collection('posts')
  //         .doc(postId)
  //         .collection('comments');

  //     if (user != null) {
  //       QuerySnapshot snapshot = await commentCollection.get();
  //       for (var doc in snapshot.docs) {
  //         Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //         PostComment comment = PostComment.fromFirestore(data);
  //         postsCommentList.add(comment);
  //       }

  //       emit(GetPostCommentSuccessState(postsCommentList));
  //     } else {
  //       emit(const PostCommentErrorState(
  //           "403 Unauthorized - Session not found"));
  //     }
  //   } catch (e) {
  //     emit(PostCommentErrorState(e.toString()));
  //   }
  // }
}
