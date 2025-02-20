import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  String _locale = "en";

  String get locale => _locale;

  set locale(String locale) {
    _locale = locale;
    notifyListeners();
  }
}
