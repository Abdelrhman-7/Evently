class Event {
  static const String collectionName = 'Events';
  String? id;
  String? titel;
  String? description;
  String? eventImage;
  String? eventName;
  DateTime? eventDateTime;
  String? eventTime;
  bool? isFavorite;
  Event({
    this.id = '',
    required this.titel,
    required this.description,
    required this.eventImage,
    required this.eventName,
    required this.eventDateTime,
    required this.eventTime,
    this.isFavorite = false,
  });
  Event.formFirstStore(Map<String, dynamic> data)
    : this(
        description: data['description'],
        eventDateTime: DateTime.fromMillisecondsSinceEpoch(
          data['eventDateTime'],
        ),
        eventImage: data['eventImage'],
        eventName: data['eventName'],
        eventTime: data['eventTime'],
        titel: data['titel'],
        id: data['id'],
        isFavorite: data['isFavorite'],
      );
  Map<String, dynamic> toFIreStore() {
    return {
      'id': id,
      'titel': titel,
      'description': description,
      'eventImage': eventImage,
      'eventName': eventName,
      'eventDateTime': eventDateTime!.millisecondsSinceEpoch,
      'eventTime': eventTime,
      'isFavorite': isFavorite,
      //add to githup
      //creat new branch from development
    };
  }
}
