import 'package:evently/Custome_text_filed/text_filed.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Favoritstab extends StatelessWidget {
  Favoritstab({super.key});
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
                    child: Container(),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: height * 0.02);
                },
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
