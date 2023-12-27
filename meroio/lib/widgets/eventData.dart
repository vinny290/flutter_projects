import 'package:flutter/material.dart';

class EventData extends ChangeNotifier {
  String title = '';

  void setTitle(String newTitle) {
    title = newTitle;
    notifyListeners();
  }
}
