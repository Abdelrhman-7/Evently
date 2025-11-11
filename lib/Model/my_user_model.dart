class MyUser {
  static const String collectionName = 'Users';
  String name;
  String id;
  String email;

  MyUser({required this.email, required this.id, required this.name});

  MyUser.fromFireStore(Map<String, dynamic> data)
    : this(email: data['email'], id: data['id'], name: data['name']);

  Map<String, dynamic> toFirestore() {
    return {'id': id, 'name': name, 'email': email};
  }
}
