import 'package:evently/Buttones/customElevatedButton.dart';
import 'package:evently/Custome_text_filed/text_filed.dart';
import 'package:evently/Home/Tabs/widget/TimeWidget/timewidget.dart';
import 'package:evently/Home/Tabs/widget/event_tab_item.dart';
import 'package:evently/Model/model.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/tost_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;

  const EditEventScreen({super.key, required this.event});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  int selectedIndex = 0;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedEventImage = '';
  String selectedEventName = '';
  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.event.titel);
    descController = TextEditingController(text: widget.event.description);
    selectedEventImage = widget.event.eventImage ?? ImageAssets.sport;
    selectedEventName = widget.event.eventName ?? '';
    selectedDate = widget.event.eventDateTime;
    if (widget.event.eventTime != null) {
      List<String> timeSplit = widget.event.eventTime!.split(':');
      selectedTime = TimeOfDay(
        hour: int.parse(timeSplit[0]),
        minute: int.parse(timeSplit[1]),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    var eventlistprovider = Provider.of<Eventlistprovider>(context);
    // ignore: unused_local_variable
    var userprovider = Provider.of<UserProvider>(context);

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
                // صورة الحدث
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
                // اختيار نوع الحدث
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
                // العنوان
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Text(
                    AppLocalizations.of(context)!.title,
                    style: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextFiled(
                  controller: titleController,
                  styletext: TextStyle(color: Theme.of(context).disabledColor),
                  borderSideColor: Theme.of(context).cardColor,
                  hintext: AppLocalizations.of(context)!.eventTitle,
                  prefixIcon: Image.asset(
                    IconManager.edit,
                    color: Theme.of(context).disabledColor,
                  ),
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                ),
                // الوصف
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Text(
                    AppLocalizations.of(context)!.description,
                    style: TextStyle(
                      color: Theme.of(context).disabledColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextFiled(
                  controller: descController,
                  styletext: TextStyle(color: Theme.of(context).disabledColor),
                  borderSideColor: Theme.of(context).cardColor,
                  hintext: AppLocalizations.of(context)!.eventDescription,
                  maxLines: 4,
                  validator: (text) {
                    if (text == null || text.trim().isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: height * 0.01),
                Timewidget(
                  image: IconManager.calnderday,
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
                      : '${selectedTime!.hour}:${selectedTime!.minute}',
                  onChooseEventOrDate: chooseTime,
                ),
                SizedBox(height: height * 0.02),
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
                    onpressed: updateEvent,
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
      initialDate: selectedDate ?? DateTime.now(),
    );
    if (chooseDate != null) {
      setState(() {
        selectedDate = chooseDate;
      });
    }
  }

  void chooseTime() async {
    var chooseTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (chooseTime != null) {
      setState(() {
        selectedTime = chooseTime;
      });
    }
  }

  void updateEvent() async {
    if (formkey.currentState?.validate() != true) return;
    final eventlistprovider = Provider.of<Eventlistprovider>(
      context,
      listen: false,
    );
    final userprovider = Provider.of<UserProvider>(context, listen: false);

    try {
      widget.event.titel = titleController.text;
      widget.event.description = descController.text;
      widget.event.eventDateTime = selectedDate;
      widget.event.eventTime =
          '${selectedTime?.hour ?? 0}:${selectedTime?.minute ?? 0}';
      widget.event.eventImage = selectedEventImage;
      widget.event.eventName = selectedEventName;

      String userId = userprovider.currentUser!.id;
      eventlistprovider.updateEventInList(widget.event, userId);

      ToastUtils.showToastMsg(
        backgroundColor: Theme.of(context).dividerColor,
        message: "Event updated successfully",
        textColor: Theme.of(context).disabledColor,
      );

      Navigator.pop(context);
    } catch (e) {
      ToastUtils.showToastMsg(
        backgroundColor: Theme.of(context).dividerColor,
        message: "Error: $e",
        textColor: Theme.of(context).disabledColor,
      );
    }
  }
}
