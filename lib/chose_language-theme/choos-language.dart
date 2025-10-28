import 'package:evently/Home/Tabs/languageBottomSheet.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/provider_language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chooslanguage extends StatelessWidget {
  const Chooslanguage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var providerlanguage = context.watch<ProviderLanguage>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.of(context)!.language,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        InkWell(
          onTap: () => showLanguageBottomSheet(context),
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
                  providerlanguage.appLanguage == "ar"
                      ? AppLocalizations.of(context)!.arabic
                      : AppLocalizations.of(context)!.english,

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

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const Languagebottomsheet(),
    );
  }
}
