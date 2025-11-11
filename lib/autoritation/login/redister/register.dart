import 'package:evently/Buttones/customElevatedButton.dart';
import 'package:evently/Custome_text_filed/text_filed.dart';
import 'package:evently/Model/my_user_model.dart';
import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/firebase/firebaseinfo.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Register extends StatelessWidget {
  Register({super.key});
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passowrdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rePassowrdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.register),
        foregroundColor: const Color(0xff5669FF),
        elevation: 0,
      ),

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
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFiled(
                        borderSideColor: Theme.of(context).cardColor,
                        hintext: AppLocalizations.of(context)!.name,

                        hintTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),

                        lableTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),

                        controller: nameController,
                        styletext: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        prefixIcon: Image.asset(IconManager.profile),
                      ),
                      TextFiled(
                        hintTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),
                        hintext: AppLocalizations.of(context)!.email,
                        prefixIcon: Image.asset(IconManager.masseg),
                        lableTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),

                        styletext: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        controller: emailController,
                        borderSideColor: Theme.of(context).cardColor,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.enterEmail;
                          }
                          final bool emailValid = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(text);
                          if (!emailValid) {
                            return AppLocalizations.of(context)!.invalidEmail;
                          }
                          return null;
                        },
                      ),
                      TextFiled(
                        hintTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),
                        prefixIcon: Image.asset(IconManager.lock),
                        hintext: AppLocalizations.of(context)!.password,
                        lableTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),
                        sufixIcon: Image.asset(IconManager.eye),
                        obscureText: true,
                        styletext: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        borderSideColor: Theme.of(context).cardColor,

                        controller: passowrdController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(context)!.enterPassword;
                          }
                          final bool enaivalid = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                          ).hasMatch(text);
                          if (!enaivalid) {
                            return AppLocalizations.of(
                              context,
                            )!.invalidPassword;
                          }
                          return null; //todo:valid
                        },
                      ),

                      TextFiled(
                        hintTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),
                        borderSideColor: Theme.of(context).cardColor,
                        prefixIcon: Image.asset(IconManager.lock),
                        hintext: AppLocalizations.of(context)!.repassword,
                        lableTextStyle: TextStyle(
                          color: Theme.of(context).cardColor,
                        ),
                        sufixIcon: Image.asset(IconManager.eye),
                        obscureText: true,
                        styletext: TextStyle(
                          color: Theme.of(context).disabledColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),

                        controller: rePassowrdController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.confirmPassword;
                          }

                          if (text != passowrdController.text) {
                            return AppLocalizations.of(
                              context,
                            )!.passwordsNotMatch;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.02),

                      Customelevatedbutton(
                        text: AppLocalizations.of(context)!.createAccount,
                        onpressed: () {
                          register(context);
                        },
                      ),
                      SizedBox(height: height * 0.02),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.alreadyHaveAccount,
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
                              ).pushNamed(RoutManager.loginScreen);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.login,
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

  void register(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    DialogUtils.showLoading(context: context, message: "Creating New Account");

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passowrdController.text.trim(),
          );
      MyUser myUser = MyUser(
        email: emailController.text.trim(),
        id: credential.user?.uid ?? '',
        name: nameController.text,
      );
      await FirebaseUtiles.addUserFireStore(myUser);
      var userprovider = Provider.of<UserProvider>(context, listen: false);
      userprovider.updateUser(myUser);
      var eventListprovider = Provider.of<Eventlistprovider>(
        context,
        listen: false,
      );

      if (userprovider.currentUser != null) {
        eventListprovider.changeSelectedIndex(0, userprovider.currentUser!.id);
      }

      if (!context.mounted) return;
      DialogUtils.hideLoding(context: context);

      if (credential.user != null) {
        // لازم تستخدم await هنا علشان Flutter يستنى لما المستخدم يضغط OK
        DialogUtils.showMasseg(
          context: context,
          message: "Account created successfully!",
          titel: 'Success',
          positiveAction: 'OK',
          posveAction: () {
            // اتأكد إن الـ context لسه mounted قبل التنقل
            if (context.mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RoutManager.homescreen,
                (route) => false,
              );
            }
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      DialogUtils.hideLoding(context: context);

      if (e.code == 'weak-password') {
        DialogUtils.showMasseg(
          context: context,
          message: "The password provided is too weak.",
          titel: 'Error',
          positiveAction: 'OK',
        );
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMasseg(
          context: context,
          message: "The account already exists for that email.",
          titel: 'Error',
          positiveAction: 'OK',
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      DialogUtils.hideLoding(context: context);

      DialogUtils.showMasseg(
        context: context,
        message: 'Something went wrong: $e',
        titel: 'Error',
        positiveAction: 'OK',
      );
    }
  }
}
