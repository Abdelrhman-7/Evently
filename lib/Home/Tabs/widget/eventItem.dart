// ignore_for_file: unrelated_type_equality_checks

import 'package:evently/Model/model.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Eventitem extends StatelessWidget {
  final Event event;
  const Eventitem({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var eventlistprovider = Provider.of<Eventlistprovider>(context);
    var userprovider = Provider.of<UserProvider>(context);
    return Container(
      height: height * 0.25,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(event.eventImage!),
        ),
        border: Border.all(color: Colormanager.blue, width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.02,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).dividerColor,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Column(
                    children: [
                      Text(
                        event.eventDateTime!.day.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                      Text(
                        DateFormat('MMM').format(event.eventDateTime!),

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).dividerColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          event.titel.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        event.isFavorite = !(event.isFavorite);
                        eventlistprovider.updateIsFavoriteEvent(
                          event,
                          userprovider.currentUser!.id,
                        );
                      },
                      child: event.isFavorite == true
                          ? Image.asset(
                              IconManager.favoriatsicon,
                              color: Theme.of(context).primaryColorDark,
                            )
                          : Image.asset(
                              IconManager.unselectedfavoriaticon,
                              color: Theme.of(context).primaryColorDark,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
