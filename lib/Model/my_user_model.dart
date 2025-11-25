import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  static const String collectionName = 'Users';

  String id;
  String name;
  String email;

  MyUser({required this.id, required this.name, required this.email});

  factory MyUser.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return MyUser(
      id: doc.id, // 👈 أهم حاجة
      name: data['name'] ?? '',
      email: data['email'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'email': email};
  }
}
