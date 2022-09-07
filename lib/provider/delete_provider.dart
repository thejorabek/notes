import 'package:flutter/widgets.dart';

class DeleteProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _delete = [];

  List<Map<String, dynamic>> get delete => _delete;

  deleteNote(var note) {
    _delete.removeAt(note);
    notifyListeners();
  }
  assNote(var note) {
    _delete.add(note);
    notifyListeners();
  }
}
