import 'package:evently/Buttones/customElevatedButton.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.forgetPassword,
          style: TextStyle(
            color: Colormanager.blue,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        //  crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(ImageAssets.resetpasswor),
          SizedBox(height: height * 0.02),
          Customelevatedbutton(
            backgroundcolor: Colormanager.blue,
            text: AppLocalizations.of(context)!.resetPassword,
            Bordercolor: Colors.transparent,
            onpressed: () {},
            textcolor: Colormanager.whitepure,
            hasIcon: true,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}
