import 'package:flutter/material.dart';
import 'package:kajian_fikih/utils/constants/category.dart';
import 'package:kajian_fikih/utils/constants/location.dart';

class FormProvider with ChangeNotifier {
  String _postType = "online";
  String _role = "jamaah";
  Location _location = Location.Semarang;
  PostCategory _category = PostCategory.Hadist;
  bool _isHidden = true;
  bool _isConfirmHidden = true;
  bool _isAgreed = false;

  String get postType => _postType;
  String get role => _role;
  Location get location => _location;
  PostCategory get category => _category;
  bool get isHidden => _isHidden;
  bool get isConfirmHidden => _isConfirmHidden;
  bool get isAgreed => _isAgreed;

  set postType(String type) {
    _postType = type;
    notifyListeners();
  }

  set role(String role) {
    _role = role;
    notifyListeners();
  }

  set location(Location location) {
    _location = location;
    notifyListeners();
  }

  set category(PostCategory category) {
    _category = category;
    notifyListeners();
  }

  changePasswordVisibility() {
    _isHidden = !_isHidden;
    notifyListeners();
  }

  changeConfirmPasswordVisibility() {
    _isConfirmHidden = !_isConfirmHidden;
    notifyListeners();
  }

  changeAgreementStatus() {
    _isAgreed = !_isAgreed;
    notifyListeners();
  }
}
