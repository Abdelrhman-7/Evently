import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evently/Model/my_user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  /// تحميل بيانات اليوزر من Firebase عند بدء التطبيق
  Future<void> loadUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      print(" No Firebase user logged in");
      return;
    }

    try {
      final doc = await FirebaseFirestore.instance
          .collection(MyUser.collectionName)
          .doc(uid)
          .get();

      if (doc.exists) {
        currentUser = MyUser.fromFirestore(doc);
        notifyListeners();
        print(" User loaded: ${currentUser!.id}");
      } else {
        print(" User document not found in Firestore");
      }
    } catch (e) {
      print(" Error loading user: $e");
    }
  }

  /// تحديث يدوي (اختياري)
  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
