import 'package:flutter/widgets.dart';

class DoneProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _done = [];

  List<Map<String, dynamic>> get done => _done;

  void addToDone(var which) {
    _done.add(which);
    notifyListeners();
  }
  removeDone(var which) {
    _done.removeAt(which);
    notifyListeners();
  }
}
