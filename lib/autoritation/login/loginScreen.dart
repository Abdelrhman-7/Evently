import 'dart:developer';

import 'package:evently/Buttones/customElevatedButton.dart';
import 'package:evently/Custome_text_filed/text_filed.dart';
import 'package:evently/Model/my_user_model.dart';
import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/firebase/firebaseinfo.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable

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
                        onpressed: () async {
                          final result = await signInWithGoogle();
                          if (result != null) {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(RoutManager.homescreen);
                          } else {
                            print("Google Sign-In cancelled or failed");
                          }
                        },

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

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            "780262578449-kvq8dn3nhj9hnlb803402or5buldbkgv.apps.googleusercontent.com",
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
      if (googleUser == null) return null; // مهم جدًا

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential firebaseUser = await FirebaseAuth.instance
          .signInWithCredential(credential);

      MyUser user = MyUser(
        id: firebaseUser.user?.uid ?? '',
        email: firebaseUser.user?.email ?? "no email provided",
        name: firebaseUser.user?.displayName ?? "no name provided",
      );

      await FirebaseUtiles.addUserFireStore(user);

      return firebaseUser; // مهم ترجع الـ UserCredential
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  void login(BuildContext context) async {
    if (!forKey.currentState!.validate()) return;

    DialogUtils.showLoading(context: context, message: "Login...");

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passowrdController.text.trim(),
      );
      if (!context.mounted) return;
      DialogUtils.hideLoding(context: context);
      if (credential.user != null) {
        DialogUtils.showMasseg(
          context: context,
          message: "Login successfly",
          titel: 'successfly',
          positiveAction: 'OK',

          posveAction: () {
            Navigator.of(context).pushReplacementNamed(RoutManager.homescreen);
          },
        );
      }
      var user = await FirebaseUtiles.readUserFromFireStore(
        credential.user?.uid ?? '',
      );

      if (!context.mounted) return;

      if (user == null) {
        return;
      }

      var userprovider = Provider.of<UserProvider>(context, listen: false);
      var eventListprovider = Provider.of<Eventlistprovider>(
        context,
        listen: false,
      );

      if (userprovider.currentUser != null) {
        eventListprovider.changeSelectedIndex(0, userprovider.currentUser!.id);
        eventListprovider.getFilterEvents(userprovider.currentUser!.id);
      }

      userprovider.updateUser(user);
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      DialogUtils.hideLoding(context: context);

      if (e.code == 'user-not-found') {
        DialogUtils.showMasseg(
          context: context,
          message: "No user found for that email.",
          titel: 'Error',
          positiveAction: 'OK',
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMasseg(
          context: context,
          message: "Wrong password. Please try again.",
          titel: 'Error',
          positiveAction: 'OK',
        );
      } else {
        DialogUtils.showMasseg(
          context: context,
          message: "Login failed: ${e.message}",
          titel: 'Error',
          positiveAction: 'OK',
        );
      }
    }
  }
}
