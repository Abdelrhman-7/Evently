import 'package:evently/Buttones/customElevatedButton.dart';
import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/chose_language-theme/choos-language.dart';
import 'package:evently/chose_language-theme/choose-teme.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Profiletabs extends StatefulWidget {
  const Profiletabs({super.key});

  @override
  State<Profiletabs> createState() => _ProfiletabsState();
}

class _ProfiletabsState extends State<Profiletabs> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colormanager.purple,
        toolbarHeight: height * 0.18,

        title: Row(
          children: [
            Image.asset(ImageAssets.titelImage),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "John Safwat ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colormanager.whitepure,
                    ),
                  ),
                  SizedBox(height: height * 0.001),
                  Text(
                    "johnsafwat.route@gmail.com ",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                      color: Colormanager.whitepure,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: height * 0.04,
          horizontal: width * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chooslanguage(),
            SizedBox(height: height * 0.02),
            Themechoose(),
            Spacer(),
            Customelevatedbutton(
              onpressed: () {
                Navigator.of(
                  context,
                ).pushReplacementNamed(RoutManager.loginScreen);
              },
              text: AppLocalizations.of(context)!.login,
              backgroundcolor: Colormanager.red,
              Bordercolor: Colormanager.red,
              hasIcon: true,
              iconWidget: Image.asset(IconManager.Exist),
            ),
          ],
        ),
      ),
    );
  }
}
