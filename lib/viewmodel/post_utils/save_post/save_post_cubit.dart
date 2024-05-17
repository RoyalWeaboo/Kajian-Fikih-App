import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/post.dart';
import 'package:kajian_fikih/viewmodel/post_utils/save_post/save_post_state.dart';

class SavePostCubit extends Cubit<SavePostState> {
  SavePostCubit() : super(SavePostInitialState());

  Future getPostSaveStatus(String uid, String docId) async {
    emit(SavePostLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        bool savedStatus = false;
        final savedPostCollection = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection("savedPosts")
            .doc(docId)
            .get();
        if (savedPostCollection.exists) {
          savedStatus = true;
        } else {}
        emit(GetSavePostStatusSuccessState(savedStatus));
      }
    } catch (e) {
      emit(SavePostErrorState(e.toString()));
    }
  }

  Future savePost(Post postData) async {
    emit(SavePostLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final savedPostCollection = FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .collection('savedPosts')
            .doc(postData.docId);

        final isPostSaved = await savedPostCollection.get();

        if (isPostSaved.exists) {
          //unsave the post
          savedPostCollection.delete();
        } else {
          //save post to user sub collection
          await FirebaseFirestore.instance
              .collection('user')
              .doc(user.uid)
              .collection('savedPosts')
              .doc(postData.docId)
              .set(postData.toFirestore());
        }

        emit(SavePostSuccessState());
      }
    } catch (e) {
      emit(SavePostErrorState(e.toString()));
    }
  }
}
