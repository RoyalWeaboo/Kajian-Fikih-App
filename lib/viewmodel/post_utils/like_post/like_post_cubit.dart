import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/post.dart';
import 'package:kajian_fikih/viewmodel/post_utils/like_post/like_post_state.dart';

class LikePostCubit extends Cubit<LikePostState> {
  LikePostCubit() : super(LikePostInitialState());

  Future getPostLikeStatus(String uid, String docId) async {
    emit(LikePostLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        bool likeStatus = false;
        final likedPostCollection = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection("likedPosts")
            .doc(docId)
            .get();
        if (likedPostCollection.exists) {
          likeStatus = true;
        } else {}
        emit(GetLikePostStatusSuccessState(likeStatus));
      }
    } catch (e) {
      emit(LikePostErrorState(e.toString()));
    }
  }

  Future likePost(Post postData) async {
    emit(LikePostLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final postCollection =
            FirebaseFirestore.instance.collection("posts").doc(postData.docId);

        final userPostCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(postData.uid)
            .collection("posts")
            .doc(postData.docId);

        final likeCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('likedPosts')
            .doc(postData.docId);

        final likedPost = await likeCollection.get();

        //since the postData is static, this variable is needed
        //so the when user like and unlike, the like count wont be minus
        int tempLikeCount = postData.likeCount;

        if (likedPost.exists) {
          //delete from user sub collection
          likeCollection.delete();

          //decrease the like count
          if (tempLikeCount > 0) {
            await userPostCollection.update({
              'likeCount': postData.likeCount - 1,
            });
            await postCollection.update({
              'likeCount': postData.likeCount - 1,
            });
          }
        } else {
          //save post detail to user sub collection
          likeCollection.set(postData.toFirestore());

          //then add like count
          await userPostCollection.update({
            'likeCount': postData.likeCount + 1,
          });
          await postCollection.update({
            'likeCount': postData.likeCount + 1,
          });
        }

        emit(LikePostSuccessState());
      }
    } catch (e) {
      emit(LikePostErrorState(e.toString()));
    }
  }
}
