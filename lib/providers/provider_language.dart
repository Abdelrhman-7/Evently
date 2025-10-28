import 'package:flutter/material.dart';

class ProviderLanguage extends ChangeNotifier {
  String appLanguage = 'en';
  void changeLanguage(String nawLanguage) {
    if (appLanguage == nawLanguage) return;

    appLanguage = nawLanguage;
    notifyListeners();
  }
}
