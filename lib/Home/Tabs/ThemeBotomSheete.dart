import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Themebotomsheete extends StatefulWidget {
  const Themebotomsheete({super.key});

  @override
  State<Themebotomsheete> createState() => _ThemebotomsheeteState();
}

class _ThemebotomsheeteState extends State<Themebotomsheete> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dark
            InkWell(
              onTap: () {
                themeProvider.changeThemeMode(ThemeMode.dark);
              },
              child: themeProvider.isDarkMode()
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                  : getUnSelectedItemWidget(AppLocalizations.of(context)!.dark),
            ),

            // Light
            InkWell(
              onTap: () {
                themeProvider.changeThemeMode(ThemeMode.light);
              },
              child: !themeProvider.isDarkMode()
                  ? getSelectedItemWidget(AppLocalizations.of(context)!.light)
                  : getUnSelectedItemWidget(
                      AppLocalizations.of(context)!.light,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colormanager.purple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Icon(Icons.check, color: Colormanager.purple),
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colormanager.purple,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
