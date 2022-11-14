import 'package:flutter/material.dart';
import 'package:list/provider/notes_provider.dart';

class CheckboxProvider extends ChangeNotifier {
  bool _isChecked = false;

  bool get isChecked => _isChecked;
  NotesProvider notes = NotesProvider();

  void makeChacked(var which) {
    _isChecked = !_isChecked;
    notifyListeners();
  }
}
