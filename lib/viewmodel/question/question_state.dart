import 'package:equatable/equatable.dart';
import 'package:kajian_fikih/model/questions.dart';

class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object?> get props => [];
}

class QuestionInitialState extends QuestionState {}

class QuestionLoadingState extends QuestionState {}

class QuestionSuccessState extends QuestionState {
  final List<Question> questionsList;

  const QuestionSuccessState(this.questionsList);
  @override
  List<Object> get props => [questionsList];
}

class QuestionErrorState extends QuestionState {
  final String errorMessage;

  const QuestionErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
