import 'package:flutter/material.dart';
import 'package:kajian_fikih/utils/constants/location.dart';

class FormProvider with ChangeNotifier {
  String _postType = "online";
  Location _location = Location.semarang;

  String get postType => _postType;
  Location get location => _location;

  set postType(String type) {
    _postType = type;
    notifyListeners();
  }

  set location(Location location) {
    _location = location;
    notifyListeners();
  }
}
