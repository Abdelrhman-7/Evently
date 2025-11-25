import 'package:evently/Home/Tabs/widget/eventItem.dart';
import 'package:evently/Home/Tabs/widget/event_tab_item.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Hometap extends StatefulWidget {
  const Hometap({super.key});

  @override
  State<Hometap> createState() => _HometapState();
}

class _HometapState extends State<Hometap> {
  late Eventlistprovider eventListProvider;
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      userProvider = Provider.of<UserProvider>(context, listen: false);
      eventListProvider = Provider.of<Eventlistprovider>(
        context,
        listen: false,
      );

      final user = userProvider.currentUser;
      if (user == null) return;

      eventListProvider.getEventNameList(context); // مرة واحدة
      eventListProvider.getAllEvents(user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    eventListProvider = Provider.of<Eventlistprovider>(context);
    userProvider = Provider.of<UserProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    eventListProvider.getEventNameList(context);
    /*
    if (eventListProvider.eventList.isEmpty) {
      eventListProvider.getAllEvents();
    }
    */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome Back ✨",
                  style: TextStyle(
                    color: Colormanager.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                userProvider.currentUser == null
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        userProvider.currentUser!.name,
                        style: const TextStyle(
                          color: Colormanager.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
              ],
            ),
            const Spacer(),
            ImageIcon(
              AssetImage(IconManager.sun),
              color: Colormanager.white,
              size: 22,
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colormanager.whitepure,
              ),
              child: Text(
                AppLocalizations.of(context)!.localeName,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
      ),

      body: Column(
        children: [
          Container(
            height: height * 0.20,
            padding: EdgeInsets.symmetric(
              vertical: height * 0.04,
              horizontal: width * 0.02,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(IconManager.Map_Pin),
                    SizedBox(width: width * 0.002),
                    Text(
                      "  Cairo , Egypt  ",
                      style: TextStyle(color: Colormanager.whitepure),
                    ),
                  ],
                ),
                DefaultTabController(
                  length: eventListProvider.eventlyNameList.length,
                  child: TabBar(
                    tabAlignment: TabAlignment.start,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    onTap: (index) {
                      eventListProvider.changeSelectedIndex(
                        index,
                        userProvider.currentUser!.id,
                      );
                    },
                    tabs: eventListProvider.eventlyNameList
                        .asMap()
                        .entries
                        .map(
                          (entry) => EventTabItem(
                            borderColor: Colormanager.whitepure,
                            isSelectedColor: Theme.of(context).primaryColor,
                            isNotSelectedColor: Colormanager.whitepure,
                            eventName: entry.value,
                            isSelected:
                                eventListProvider.selectedIndex == entry.key,
                            backGround: Colormanager.whitepure,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: eventListProvider.filterAllEvents.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.noeventfound,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        child: Eventitem(
                          event: eventListProvider.filterAllEvents[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: height * 0.02);
                    },
                    itemCount: eventListProvider.filterAllEvents.length,
                  ),
          ),
        ],
      ),
    );
  }
}
