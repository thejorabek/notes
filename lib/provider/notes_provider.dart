import 'package:flutter/material.dart';

class NotesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _notes = [];

  List<Map<String, dynamic>> get notes => _notes;

  void addToNotes(Map<String, dynamic> note) {
    _notes.add(note);
    notifyListeners();
  }
  void removeNote(var note) {
    _notes.removeAt(note);
    notifyListeners();
  }


}
