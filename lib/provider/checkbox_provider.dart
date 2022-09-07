import 'package:flutter/material.dart';

class CheckboxProvider extends ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;

  void makeChacked() {
    _isChecked = !_isChecked;
    notifyListeners();
  }
}
