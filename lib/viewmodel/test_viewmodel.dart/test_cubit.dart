//THIS VIEWMODEL IS FOR DEVELOPMENT PURPOSE ONLY
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/dummy_models.dart';
import 'package:kajian_fikih/viewmodel/test_viewmodel.dart/test_state.dart';

class TestViewModelCubit extends Cubit<TestViewModelState> {
  TestViewModelCubit() : super(TestViewModelInitialState());

  Future postQuestion(
    String question,
    String a,
    String b,
    String c,
    String d,
    String correctAnswer,
  ) async {
    emit(TestViewModelLoadingState());
    try {
      final questionCollection =
          FirebaseFirestore.instance.collection('questions');
      final id = questionCollection.doc().id;

      await questionCollection.doc(id).set(
          DummyQuestion(id, question, a, b, c, d, correctAnswer).toFirestore());

      emit(TestViewModelSuccessState());
    } catch (e) {
      emit(TestViewModelErrorState(e.toString()));
    }
  }
}
