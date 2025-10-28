import 'package:evently/Buttones/customElevatedButton.dart';
import 'package:evently/Custome_text_filed/text_filed.dart';
import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});
  final forKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passowrdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: height * 0.02),
                Image.asset(ImageAssets.splash),
                SizedBox(height: height * 0.02),
                Form(
                  key: forKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: height * 0.02),
                      TextFiled(
                        controller: emailController,
                        styletext: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        borderSideColor: Theme.of(context).cardColor,
                        hintTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),
                        hintext: AppLocalizations.of(context)!.email,
                        prefixIcon: Image.asset(
                          IconManager.profile,
                          color: Theme.of(context).cardColor,
                        ),
                        keyBordType: TextInputType.emailAddress,

                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.enterEmail;
                          }
                          final bool enaivalid = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(text);
                          if (!enaivalid) {
                            return AppLocalizations.of(context)!.invalidEmail;
                          }
                          return null; //todo:valid
                        },
                      ),
                      TextFiled(
                        controller: passowrdController,
                        styletext: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        borderSideColor: Theme.of(context).cardColor,
                        hintTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),
                        hintext: AppLocalizations.of(context)!.password,
                        prefixIcon: Image.asset(
                          IconManager.lock,
                          color: Theme.of(context).cardColor,
                        ),
                        sufixIcon: Image.asset(
                          IconManager.eye,
                          color: Theme.of(context).cardColor,
                        ),
                        keyBordType: TextInputType.number,
                        obscureText: true,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.enterPassword;
                          }
                          final bool passwordValid = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          ).hasMatch(text);
                          if (!passwordValid) {
                            return AppLocalizations.of(
                              context,
                            )!.passwordsNotMatch;
                          }
                          return null; //todo:valid
                        },
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(RoutManager.forgetPassword);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.forgetPassword,
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).canvasColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Customelevatedbutton(
                        iconWidget: Image.asset(
                          IconManager.googleIcon,
                          color: Theme.of(context).canvasColor,
                        ),
                        text: AppLocalizations.of(context)!.login,
                        onpressed: () => login(context),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dontHaveAccount,
                            style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(
                                context,
                              ).pushNamed(RoutManager.register);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.createAccount,
                              style: TextStyle(
                                color: Theme.of(context).canvasColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).canvasColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colormanager.blue,
                              thickness: 2,
                              endIndent: width * 0.04,
                              indent: width * 0.02,
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.or,
                            style: TextStyle(
                              color: Theme.of(context).canvasColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colormanager.blue,
                              thickness: 2,
                              endIndent: width * 0.04,
                              indent: width * 0.02,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      Customelevatedbutton(
                        iconWidget: Image.asset(IconManager.googleIcon),
                        backgroundcolor: Colors.transparent,
                        textStyle: TextStyle(
                          color: Theme.of(context).canvasColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        text: AppLocalizations.of(context)!.loginWithGoogle,
                        Bordercolor: Theme.of(context).canvasColor,
                        onpressed: () => login(context),
                        textcolor: Colormanager.whitepure,
                        hasIcon: true,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context) {
    if (forKey.currentState?.validate() == true) {
      Navigator.of(context).pushReplacementNamed(RoutManager.homescreen);
    }
  }
}
