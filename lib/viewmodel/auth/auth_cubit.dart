import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kajian_fikih/model/user_detail.dart';
import 'package:kajian_fikih/viewmodel/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(InitialState());

  Future login(
    String email,
    String password,
  ) async {
    emit(LoadingState());
    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var collection = FirebaseFirestore.instance.collection("user");
      await collection.doc(credential.user!.uid).get().then(
        (DocumentSnapshot querySnapshot) {
          if (querySnapshot.exists && querySnapshot.data() != null) {
            UserDetail userData = UserDetail.fromFirestore(
                querySnapshot.data() as Map<String, dynamic>);

            emit(LoginSuccessState(userData));
          }
        },
        onError: (e) => emit(
          LoginErrorState(e.toString()),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          const LoginErrorState("No user found."),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          const LoginErrorState("Wrong password."),
        );
      }
    } catch (e) {
      emit(
        LoginErrorState(e.toString()),
      );
    }
  }

  Future loginWithGoogle() async {
    emit(LoadingState());

    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;

        emit(GoogleLoginSuccessState(user!));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          emit(
            const LoginErrorState("Account rxist with different credential"),
          );
        } else if (e.code == 'invalid-credential') {
          emit(
            const LoginErrorState("Invalid credential"),
          );
        }
      } catch (e) {
        emit(
          LoginErrorState(e.toString()),
        );
      }
    }
  }

  Future register(
    String username,
    String email,
    String phone,
    String password,
    String location,
    String profilePictureUrl,
    String role,
  ) async {
    emit(LoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      var collection = FirebaseFirestore.instance.collection('user');
      var userData = UserDetail(
        uid: user!.uid,
        docId: collection.doc().id,
        email: email,
        username: username,
        phone: phone,
        location: location,
        profilePictureUrl: profilePictureUrl,
        role: role,
      );
      await collection
          .doc(user.uid)
          .set(userData.toFirestore())
          .then(
            (_) => emit(
              RegisterSuccessState(userData),
            ),
          )
          .catchError(
            (error) => emit(
              RegisterErrorState(error.toString()),
            ),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
          const RegisterErrorState("The password provided is too weak."),
        );
        emit(
          InitialState(),
        );
      } else if (e.code == 'email-already-in-use') {
        emit(
          const RegisterErrorState(
              "The account already exists for that email."),
        );
      }
    } catch (e) {
      emit(
        RegisterErrorState(
          e.toString(),
        ),
      );
    }
  }
}
