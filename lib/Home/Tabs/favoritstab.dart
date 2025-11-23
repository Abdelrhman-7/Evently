import 'package:evently/Custome_text_filed/text_filed.dart';
import 'package:evently/Home/Tabs/widget/eventItem.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Favoritstab extends StatefulWidget {
  const Favoritstab({super.key});

  @override
  State<Favoritstab> createState() => _FavoritstabState();
}

class _FavoritstabState extends State<Favoritstab> {
  TextEditingController searchController = TextEditingController();
  late Eventlistprovider eventlistprovider;
  late UserProvider userProvider;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = userProvider.currentUser;

      if (user == null) {
        print(" userProvider.currentUser is NULL in FavoriteTab");
        return;
      }

      eventlistprovider.getAllFavoiriteEvents(user.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    userProvider = Provider.of<UserProvider>(context);
    eventlistprovider = Provider.of<Eventlistprovider>(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.02),
        child: Column(
          children: [
            TextFiled(
              controller: searchController,
              borderSideColor: Colormanager.blue,
              hintext: AppLocalizations.of(context)!.search,
              hintTextStyle: TextStyle(color: Theme.of(context).canvasColor),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Eventitem(
                      event: eventlistprovider.favoiteList[index],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.02);
                },
                itemCount: eventlistprovider.favoiteList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
