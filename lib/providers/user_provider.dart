import 'package:evently/Model/my_user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
