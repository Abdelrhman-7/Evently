import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Model/model.dart';
import 'package:evently/Model/my_user_model.dart';

class FirebaseUtiles {
  static Future<void> addEventToFireStore(Event event, String uId) async {
    CollectionReference<Event> collection = getEventCollection(uId);
    DocumentReference<Event> docRef = collection.doc();
    event.id = docRef.id;
    await docRef.set(event);
  }

  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, _) => snapshot.data() != null
              ? Event.fromFirestore(snapshot)
              : throw Exception("Event doc is null"),
          toFirestore: (event, _) => event.toFirestore(),
        );
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, _) => snapshot.data() != null
              ? MyUser.fromFirestore(snapshot)
              : throw Exception("User doc is null"),
          toFirestore: (user, _) => user.toFirestore(),
        );
  }

  static Future<void> addUserFireStore(MyUser myUser) async {
    await getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String id) async {
    var docSnap = await getUserCollection().doc(id).get();
    return docSnap.data();
  }

  static Future<void> deleteEvent(String eventId, String uId) async {
    await getEventCollection(uId).doc(eventId).delete();
  }

  static Future<void> updateEvent(Event event, String uId) async {
    await getEventCollection(uId).doc(event.id).update(event.toFirestore());
  }
}
