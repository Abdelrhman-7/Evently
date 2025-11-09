import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Model/model.dart';

class FirebaseUtiles {
  static Future<void> addEventToFireStore(Event event) {
    //1-creat collection
    CollectionReference<Event> collection = getEventCollection();
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

  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromFirestore(snapshot.data()!),
          toFirestore: (event, options) => event.toFirestore(),
        );
  }
}
