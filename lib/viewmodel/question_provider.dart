import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kajian_fikih/model/questions.dart';

class QuestionProvider with ChangeNotifier {
  int _questionNumber = 1;
  Timer? countdownTimer;
  int _timerDuration = 30;
  bool _isTimerRunning = false;
  int _rightAnswerCount = 0;
  String _answer = "a";
  // Question question = Question(
  //   docId: "",
  //   question: "",
  //   a: "",
  //   b: "",
  //   c: "",
  //   d: "",
  //   correctAnswer: "",
  // );
  List<Question> _question = [];

  int get questionNumber => _questionNumber;
  int get timerDuration => _timerDuration;
  int get rightAnswerCount => _rightAnswerCount;
  String get answer => _answer;
  List<Question> get question => _question;

  set question(List<Question> q) {
    _question = q;
    notifyListeners();
  }

  resetQuestionNumber() {
    _questionNumber = 1;
    notifyListeners();
  }

  resetTimerDuration() {
    _timerDuration = 30;
    notifyListeners();
  }

  resetRightAnswerCount() {
    _rightAnswerCount = 0;
    notifyListeners();
  }

  incrementQuestionNumber() {
    _questionNumber++;
    notifyListeners();
  }

  incrementRightAnswerCount() {
    _rightAnswerCount++;
    notifyListeners();
  }

  void startCountdownTimer() {
    if (!_isTimerRunning) {
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (timerDuration > 0) {
          _timerDuration--;
          notifyListeners();
        } else {
          timer.cancel();
          _isTimerRunning = false;
          notifyListeners();
        }
      });
      _isTimerRunning = true;
      notifyListeners();
    }
  }

  set answer(String ans) {
    _answer = ans;
    notifyListeners();
  }
}
