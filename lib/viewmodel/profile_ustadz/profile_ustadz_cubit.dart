import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kajian_fikih/model/offline_event.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/model/ustadz_profile_detail.dart';
import 'package:kajian_fikih/viewmodel/profile_ustadz/profile_ustadz_state.dart';

class ProfileUstadzCubit extends Cubit<ProfileUstadzState> {
  ProfileUstadzCubit() : super(ProfileUstadzInitialState());

  Future getProfileDetail() async {
    emit(ProfileUstadzLoadingState());
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var collection = FirebaseFirestore.instance.collection("user");
      try {
        final offlineEventCollection =
            await collection.doc(currentUser.uid).collection("events").get();

        await collection.doc(currentUser.uid).get().then(
          (DocumentSnapshot querySnapshot) {
            if (querySnapshot.exists && querySnapshot.data() != null) {
              UserDetail userData = UserDetail.fromFirestore(
                  querySnapshot.data() as Map<String, dynamic>);

              //get kajian
              final List<OfflineEvent> offlineEvents =
                  offlineEventCollection.docs.map((doc) {
                final data = doc.data();
                return OfflineEvent.fromFirestore(data);
              }).toList();

              emit(
                ProfileUstadzSuccessState(
                  userDetail: userData,
                  ustadzProfileDetail: UstadzProfileDetail(
                    uid: userData.uid,
                    kajianCount: offlineEventCollection.size,
                    followerCount: userData.followerCount ?? 0,
                    offlineEvents: offlineEvents,
                  ),
                ),
              );
            }
          },
          onError: (e) => emit(
            ProfileUstadzErrorState(e.toString()),
          ),
        );
      } catch (e) {
        emit(ProfileUstadzErrorState(e.toString()));
      }
    } else {
      emit(const ProfileUstadzErrorState("Invalid User"));
    }
  }

  Future getProfileDetailByUserId(String uid) async {
    emit(ProfileUstadzLoadingState());
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      var collection = FirebaseFirestore.instance.collection("user");
      try {
        final offlineEventCollection =
            await collection.doc(uid).collection("events").get();

        await collection.doc(uid).get().then(
          (DocumentSnapshot querySnapshot) {
            if (querySnapshot.exists && querySnapshot.data() != null) {
              UserDetail userData = UserDetail.fromFirestore(
                  querySnapshot.data() as Map<String, dynamic>);

              //get kajian
              final List<OfflineEvent> offlineEvents =
                  offlineEventCollection.docs.map((doc) {
                final data = doc.data();
                return OfflineEvent.fromFirestore(data);
              }).toList();

              emit(
                ProfileUstadzSuccessState(
                  userDetail: userData,
                  ustadzProfileDetail: UstadzProfileDetail(
                    uid: userData.uid,
                    kajianCount: offlineEventCollection.size,
                    followerCount: userData.followerCount ?? 0,
                    offlineEvents: offlineEvents,
                  ),
                ),
              );
            }
          },
          onError: (e) => emit(
            ProfileUstadzErrorState(e.toString()),
          ),
        );
      } catch (e) {
        emit(ProfileUstadzErrorState(e.toString()));
      }
    } else {
      emit(const ProfileUstadzErrorState("Invalid User"));
    }
  }

  Future updateProfileDetail(
    String username,
    String email,
    String phone,
    String location,
    String description,
    String? existingImageUrl,
    XFile? imageFile,
  ) async {
    emit(ProfileUstadzLoadingState());
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String imageUrl = "";

      try {
        var userData = UserDetail(
          uid: currentUser.uid,
          email: email,
          username: username,
          phone: phone,
          location: location,
          profilePictureUrl: imageUrl,
          description: description,
          role: "ustadz",
        );

        //upload image first if image file available
        if (imageFile != null) {
          //upload image to firebase storage
          String uniqueFilename =
              DateTime.now().millisecondsSinceEpoch.toString();

          final storageRef = FirebaseStorage.instance;
          Reference dirUpload =
              storageRef.ref().child('profile/${currentUser.uid}');
          Reference storedDir = dirUpload.child(uniqueFilename);
          await storedDir.putFile(File(imageFile.path));

          //get image url from firebase storage
          imageUrl = await storedDir.getDownloadURL();
        }

        //updated data
        if (existingImageUrl != "" && imageFile == null) {
          //if user have profile image but not update
          userData = UserDetail(
            uid: currentUser.uid,
            email: email,
            username: username,
            phone: phone,
            location: location,
            profilePictureUrl: existingImageUrl!,
            description: description,
            role: "ustadz",
          );
        } else {
          userData = UserDetail(
            uid: currentUser.uid,
            email: email,
            username: username,
            phone: phone,
            location: location,
            profilePictureUrl: imageUrl,
            description: description,
            role: "ustadz",
          );
        }

        var collection = FirebaseFirestore.instance.collection("user");

        await collection.doc(currentUser.uid).set(userData.toFirestore());
        emit(ProfileUstadzUpdateSuccessState());
      } catch (e) {
        emit(ProfileUstadzErrorState(e.toString()));
      }
    } else {
      emit(const ProfileUstadzErrorState("Invalid User"));
    }
  }

  Future logout() async {
    emit(ProfileUstadzLoadingState());
    try {
      await FirebaseAuth.instance.signOut();
      emit(ProfileUstadzLogoutSuccessState());
    } catch (e) {
      emit(ProfileUstadzLogoutErrorState(e.toString()));
    }
  }
}
