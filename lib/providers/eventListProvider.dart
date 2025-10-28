import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Model/model.dart';
import 'package:evently/firebase/firebaseinfo.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Eventlistprovider extends ChangeNotifier {
  List<Event> eventList = [];
  List<Event> filterAllEvents = [];
  List<String> eventlyNameList = [];
  int selectedIndex = 0;

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

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtiles.getEventCollection().get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    filterAllEvents = eventList;
    notifyListeners();
  }

  void getFilterEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtiles.getEventCollection().get();

    eventList = querySnapshot.docs.map((doc) => doc.data()).toList();

    filterAllEvents = eventList.where((event) {
      return event.eventName == eventlyNameList[selectedIndex];
    }).toList();

    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex) async {
    selectedIndex = newSelectedIndex;
    notifyListeners();

    if (selectedIndex == 0) {
      getAllEvents();
    } else {
      getFilterEvents();
    }
  }
}
