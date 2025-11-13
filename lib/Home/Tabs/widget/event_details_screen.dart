import 'package:evently/Custome_text_filed/text_location.dart';
import 'package:evently/Home/Tabs/widget/event_edit_screen.dart';
import 'package:evently/Model/model.dart';
import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  // Function to delete the event
  void deleteEvent(BuildContext context) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final provider = Provider.of<Eventlistprovider>(context, listen: false);

      provider.deleteEventFromList(event.id!, userId);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Event deleted successfully')),
      );

      Navigator.pop(context); // Go back after deletion
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error while deleting: $e')));
    }
  }

  // Function to edit the event
  void editEvent(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => EditEventScreen(event: event)),
    );
  }

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(event.titel ?? "")),
        actions: [
          IconButton(
            icon: const Icon(Icons.mode_edit_outlined),
            onPressed: () => editEvent(context),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colormanager.red),
            onPressed: () => deleteEvent(context),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: hight * 0.04,
        ),
        child: ListView(
          children: [
            event.eventImage != null && event.eventImage!.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      event.eventImage!,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: hight * 0.02,
                    ),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16), // حواف مدورة
                    ),
                    clipBehavior: Clip.antiAlias, 
                    child: const Icon(Icons.image_not_supported, size: 50),
                  ),

            const SizedBox(height: 16),
            TextLocation(
              onPressed: () {
                Navigator.pushNamed(context, RoutManager.maps);
              },

              image: IconManager.calander,
              eventDateTime: event.eventDateTime,
              text: event.eventTime ?? "No time",
            ),
            SizedBox(height: hight * 0.01),

            TextLocation(
              onPressed: () {
                Navigator.pushNamed(context, RoutManager.maps);
              },
              image: IconManager.location,
              text: "Cairo , Egypt",
            ),
            SizedBox(height: hight * 0.01),
            Text(
              "Description",
              style: TextStyle(
                color: Theme.of(context).disabledColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: hight * 0.01),
            event.description != null && event.description!.isNotEmpty
                ? Text(
                    event.description ?? "",
                    style: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : Text("Text Not Found"),
          ],
        ),
      ),
    );
  }
}
