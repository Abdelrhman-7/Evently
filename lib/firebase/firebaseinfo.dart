import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Model/model.dart';
import 'package:evently/Model/my_user_model.dart';

class FirebaseUtiles {
  static Future<void> addEventToFireStore(Event event, String uId) {
    //1-creat collection
    CollectionReference<Event> collection = getEventCollection(uId);
    //2-creat decoment
    DocumentReference<Event> docRef = collection.doc();
    //3-assign auto doc id to event id
    event.id = docRef.id;
    //4-save date
    return docRef.set(event);
    //another solve
    /*
    FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.formFirstStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFIreStore(),
        ).doc().set(data);
      **************collection =>daecoment=>data**********

    */
  }

  static CollectionReference<Event> getEventCollection(String uId) {
    return getUserCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFirestore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }

  static Future<void> addUserFireStore(MyUser myUser) async {
    await getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromeFireStore(String id) async {
    var querySnapshot = await getUserCollection().doc(id).get();
    return querySnapshot.data();
  }

  static Future<void> deleteEvent(String eventId, String uId) async {
    await getEventCollection(uId).doc(eventId).delete();
  }

  static Future<void> updateEvent(Event event, String uId) async {
    await getEventCollection(uId).doc(event.id).update(event.toFirestore());
  }
}
