import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const String collectionName = 'Events';

  String? id;
  String? titel;
  String? description;
  String? eventImage;
  String? eventName;
  DateTime? eventDateTime;
  String? eventTime;
  bool isFavorite;

  Event({
    this.id,
    required this.titel,
    required this.description,
    required this.eventImage,
    required this.eventName,
    required this.eventDateTime,
    required this.eventTime,
    this.isFavorite = false,
  });

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Event(
      id: doc.id,
      titel: data['titel'] ?? '',
      description: data['description'] ?? '',
      eventImage: data['eventImage'] ?? '',
      eventName: data['eventName'] ?? '',
      eventDateTime: data['eventDateTime'] != null
          ? (data['eventDateTime'] is Timestamp
                ? (data['eventDateTime'] as Timestamp).toDate()
                : DateTime.fromMillisecondsSinceEpoch(data['eventDateTime']))
          : null,
      eventTime: data['eventTime'] ?? '',
      isFavorite: data['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'titel': titel,
      'description': description,
      'eventImage': eventImage,
      'eventName': eventName,
      'eventDateTime': eventDateTime != null
          ? Timestamp.fromDate(eventDateTime!)
          : null,
      'eventTime': eventTime,
      'isFavorite': isFavorite,
    };
  }
}
