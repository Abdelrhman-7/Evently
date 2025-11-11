import 'package:evently/Buttones/customElevatedButton.dart';
import 'package:evently/Custome_text_filed/text_filed.dart';
import 'package:evently/Home/Tabs/widget/TimeWidget/timewidget.dart';
import 'package:evently/Home/Tabs/widget/event_tab_item.dart';
import 'package:evently/Model/model.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/firebase/firebaseinfo.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/utils/tost_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Addevent extends StatefulWidget {
  const Addevent({super.key});
  @override
  State<Addevent> createState() => _AddeventState();
}

class _AddeventState extends State<Addevent> {
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedEventImage = ImageAssets.sport;
  String selectedEventName = '';
  TextEditingController eventTitelController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  late Eventlistprovider eventListProvider;
  @override
  void dispose() {
    eventTitelController.dispose();
    eventDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider = Provider.of<Eventlistprovider>(context);
    List<String> eventListName = [
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

    List<String> eventImageList = [
      ImageAssets.sport,
      ImageAssets.birthday,
      ImageAssets.meeting,
      ImageAssets.gaming,
      ImageAssets.workshop,
      ImageAssets.bookclub,
      ImageAssets.exhibition,
      ImageAssets.holiday,
      ImageAssets.eating,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.createEvent,
          style: TextStyle(
            color: Colormanager.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03,
                    vertical: height * 0.02,
                  ),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Image.asset(selectedEventImage),
                  ),
                ),
                DefaultTabController(
                  length: eventListName.length,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    isScrollable: true,

                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                        selectedEventImage = eventImageList[selectedIndex];
                        selectedEventName = eventListName[selectedIndex];
                      });
                    },
                    tabs: eventListName
                        .asMap()
                        .entries
                        .map(
                          (entry) => EventTabItem(
                            borderColor: Colormanager.blue,
                            isSelectedColor: Theme.of(context).dividerColor,
                            backGround: Colormanager.blue,
                            isNotSelectedColor: Colormanager.blue,
                            eventName: entry.value,
                            isSelected: selectedIndex == entry.key,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    ),
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                TextFiled(
                  styletext: TextStyle(color: Theme.of(context).disabledColor),
                  controller: eventTitelController,
                  borderSideColor: Theme.of(context).cardColor,
                  hintTextStyle: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                  prefixIcon: Image.asset(
                    IconManager.edit,
                    color: Theme.of(context).disabledColor,
                  ),

                  hintext: AppLocalizations.of(context)!.eventTitle,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter titel';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                    ),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                TextFiled(
                  styletext: TextStyle(color: Theme.of(context).disabledColor),

                  controller: eventDescriptionController,
                  borderSideColor: Theme.of(context).cardColor,
                  hintTextStyle: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                  lableTextStyle: TextStyle(
                    color: Theme.of(context).disabledColor,
                  ),
                  hintext: AppLocalizations.of(context)!.eventDescription,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter Description';
                    }
                    return null;
                  },

                  maxLines: 4,
                ),
                SizedBox(height: height * 0.01),
                Timewidget(
                  image: IconManager.calander,
                  text: AppLocalizations.of(context)!.eventDate,
                  chooseDateOrTime: selectedDate == null
                      ? AppLocalizations.of(context)!.chooseDate
                      : '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',

                  onChooseEventOrDate: chooseDate,
                ),
                Timewidget(
                  image: IconManager.clock,
                  text: AppLocalizations.of(context)!.eventTime,
                  chooseDateOrTime: selectedTime == null
                      ? AppLocalizations.of(context)!.chooseTime
                      : '${selectedTime!.hour}/${selectedTime!.minute}',

                  onChooseEventOrDate: chooseTime,
                ),
                SizedBox(height: height * 0.01),

                Row(
                  children: [
                    SizedBox(width: width * 0.05),
                    Text(
                      AppLocalizations.of(context)!.eventLocation,
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.001),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.009,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 2, color: Colormanager.blue),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02,
                      vertical: height * 0.009,
                    ),
                    clipBehavior: Clip.antiAlias,

                    child: Row(
                      children: [
                        Image.asset(IconManager.location),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            AppLocalizations.of(context)!.chooseEventLocation,
                            style: TextStyle(
                              color: Colormanager.blue,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04,
                    vertical: height * 0.009,
                  ),
                  child: Customelevatedbutton(
                    iconWidget: Image.asset(
                      IconManager.googleIcon,
                      color: Theme.of(context).canvasColor,
                    ),
                    text: AppLocalizations.of(context)!.addEvent,
                    onpressed: () {
                      addEvent();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void chooseDate() async {
    var chooseDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDate: DateTime.now(),
    );
    selectedDate = chooseDate;
    setState(() {});
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    // ignore: unrelated_type_equality_checks
    selectedTime = chooseTime;
    setState(() {});
  }

  void addEvent() {
    if (formkey.currentState?.validate() == true) {
      Event event = Event(
        description: eventDescriptionController.text,
        eventDateTime: selectedDate,
        eventImage: selectedEventImage,
        eventName: selectedEventName,
        eventTime: "${selectedTime!.hour}:${selectedTime!.minute}",
        titel: eventTitelController.text,
      );

      FirebaseUtiles.addEventToFireStore(event).then((_) {
        ToastUtils.showToastMsg(
          backgroundColor: Theme.of(context).dividerColor,
          message: "Event Added successfully",
          // ignore: use_build_context_synchronously
          textColor: Theme.of(context).disabledColor,
        );
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      });
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    eventListProvider.getAllEvents();
  }
}
//التعامل مع ال fututre function
//1- wait - asyn function
//2-call backfunction
//online=>then
//ofline=>timeout
//onError=>الخطاء فين بالظبط
//catchError=> بطلع خطاء بس