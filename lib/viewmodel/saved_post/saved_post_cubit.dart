import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/post.dart';
import 'package:kajian_fikih/viewmodel/saved_post/saved_post_state.dart';

class SavedPostCubit extends Cubit<SavedPostState> {
  SavedPostCubit() : super(SavedPostInitialState());

  Future getSavedPost() async {
    emit(SavedPostLoadingState());

    try {
      List<Post> postsList = [];
      final user = FirebaseAuth.instance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('user');
      if (user != null) {
        QuerySnapshot snapshot =
            await userCollection.doc(user.uid).collection("savedPosts").get();
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Post post = Post.fromFirestore(data);
          postsList.add(post);
        }
        emit(SavedPostSuccessState(postsList));
      } else {
        emit(const SavedPostErrorState("403 Unauthorized - No User Found"));
      }
    } catch (e) {
      emit(SavedPostErrorState(e.toString()));
    }
  }
}
