import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kajian_fikih/model/questions.dart';
import 'package:kajian_fikih/viewmodel/question/question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  QuestionCubit() : super(QuestionInitialState());

  Future getQuestionList() async {
    try {
      emit(QuestionLoadingState());
      List<Question> questionList = [];

      final snapshot =
          await FirebaseFirestore.instance.collection('questions').get();
      if (snapshot.docs.isNotEmpty) {
        for (var q in snapshot.docs) {
          questionList.add(Question.fromFirestore(q.data()));
        }
        emit(QuestionSuccessState(questionList));
      } else {
        emit(const QuestionErrorState("404 - Not Found"));
      }
    } catch (e) {
      emit(QuestionErrorState(e.toString()));
    }
  }
}
