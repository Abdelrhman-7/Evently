import 'package:evently/Home/Tabs/ThemeBotomSheete.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Themechoose extends StatelessWidget {
  const Themechoose({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<AppThemeProvider>();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.theme,
          style: Theme.of(context).textTheme.headlineLarge,
        ),

        InkWell(
          onTap: () => showThemeBottomSheet(context),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.02),
            padding: EdgeInsets.symmetric(
              vertical: height * 0.02,
              horizontal: width * 0.04,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colormanager.purple, width: 2),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  themeProvider.appTheme == ThemeMode.dark
                      ? AppLocalizations.of(context)!.dark
                      : AppLocalizations.of(context)!.light,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colormanager.purple,
                  ),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colormanager.purple,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Themebotomsheete(),
    );
  }
}
