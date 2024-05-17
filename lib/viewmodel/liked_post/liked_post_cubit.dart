import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/post.dart';
import 'package:kajian_fikih/viewmodel/liked_post/liked_post_state.dart';

class LikedPostCubit extends Cubit<LikedPostState> {
  LikedPostCubit() : super(LikedPostInitialState());

  Future getLikedPost() async {
    emit(LikedPostLoadingState());

    try {
      List<Post> postsList = [];
      final user = FirebaseAuth.instance.currentUser;
      final userCollection = FirebaseFirestore.instance.collection('user');
      if (user != null) {
        QuerySnapshot snapshot =
            await userCollection.doc(user.uid).collection("likedPosts").get();
        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          Post post = Post.fromFirestore(data);
          postsList.add(post);
        }
        emit(LikedPostSuccessState(postsList));
      } else {
        emit(const LikedPostErrorState("403 Unauthorized - No User Found"));
      }
    } catch (e) {
      emit(LikedPostErrorState(e.toString()));
    }
  }
}
