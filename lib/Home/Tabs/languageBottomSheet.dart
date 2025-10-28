import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/provider_language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Languagebottomsheet extends StatefulWidget {
  const Languagebottomsheet({super.key});

  @override
  State<Languagebottomsheet> createState() => _LanguagebottomsheetState();
}

class _LanguagebottomsheetState extends State<Languagebottomsheet> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<ProviderLanguage>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.02,
        horizontal: width * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('en');
              setState(() {});
            },
            child: languageProvider.appLanguage == 'en'
                ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                : UnSelectedItemWidget(AppLocalizations.of(context)!.english),
          ),
          SizedBox(height: height * 0.02),
          InkWell(
            onTap: () {
              languageProvider.changeLanguage('ar');
              setState(() {});
            },
            child: languageProvider.appLanguage == 'ar'
                ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                : UnSelectedItemWidget(AppLocalizations.of(context)!.arabic),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String language) {
    return Row(
      children: [
        Text(
          language,
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

  // ignore: non_constant_identifier_names
  Widget UnSelectedItemWidget(String language) {
    return Text(
      language,
      style: TextStyle(
        color: Colormanager.purple,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
