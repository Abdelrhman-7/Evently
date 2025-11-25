// event_list_provider.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Model/model.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/firebase/firebaseinfo.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/tost_utils.dart';
import 'package:flutter/material.dart';

class Eventlistprovider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filterAllEvents = [];
  List<String> eventlyNameList = [];
  List<Event> favoiteList = [];

  int selectedIndex = 0;

  List<String> eventKeys = [
    "all",
    "sport",
    "birthday",
    "meeting",
    "gaming",
    "workshop",
    "bookClub",
    "exhibition",
    "holiday",
    "eating",
  ];

  List<String> getEventNameList(BuildContext context) {
    return eventlyNameList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workshop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  void getAllEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtiles.getEventCollection(uId).get();

    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    filterAllEvents = eventList;
    notifyListeners();
  }

  void getFilterEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtiles.getEventCollection(uId).get();

    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();

    filterAllEvents = eventList.where((event) {
      return event.eventName == eventlyNameList[selectedIndex];
    }).toList();

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, String uId) async {
    selectedIndex = newSelectedIndex;
    notifyListeners();

    if (selectedIndex == 0) {
      getAllEvents(uId);
    } else {
      getFilterEvents(uId);
    }
  }

  void updateIsFavoriteEvent(Event event, String uId) {
    FirebaseUtiles.getEventCollection(
      uId,
    ).doc(event.id).update({'isFavorite': event.isFavorite}).then((_) {
      ToastUtils.showToastMsg(
        message: event.isFavorite
            ? "Added to Favorites"
            : "Removed from Favorites",
        backgroundColor: Colormanager.blue,
        textColor: Colormanager.white,
      );
    });

    int index = eventList.indexWhere((e) => e.id == event.id);
    if (index != -1) {
      eventList[index].isFavorite = event.isFavorite;
    }

    getAllFavoiriteEvents(uId);
    notifyListeners();
  }

  void getAllFavoiriteEvents(String uId) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtiles.getEventCollection(uId).get();

    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();
    favoiteList = eventList.where((event) => event.isFavorite).toList();
    notifyListeners();
  }

  void updateEventInList(Event updatedEvent, String uId) async {
    try {
      await FirebaseUtiles.updateEvent(updatedEvent, uId);
      int index = eventList.indexWhere((event) => event.id == updatedEvent.id);
      if (index != -1) {
        eventList[index] = updatedEvent;
      }
      notifyListeners();
    } catch (e) {
      print("Error updating event: $e");
    }
  }

  void deleteEventFromList(String eventId, String uId) async {
    await FirebaseUtiles.deleteEvent(eventId, uId);
    eventList.removeWhere((event) => event.id == eventId);
    filterAllEvents.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }
}
