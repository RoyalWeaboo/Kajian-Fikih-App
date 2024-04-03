import 'package:flutter/material.dart';

class BottomNavbarComponentViewModel extends ChangeNotifier {
  // Add your state and logic here
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
