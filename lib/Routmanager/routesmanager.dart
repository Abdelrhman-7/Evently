import 'package:evently/Home/AddEvent/addEvent.dart';
import 'package:evently/Home/Tabs/profiletabs.dart';
import 'package:evently/Home/Tabs/widget/forgetPassword/forgetPassword.dart';
import 'package:evently/Home/home.dart';
import 'package:evently/autoritation/login/loginScreen.dart';
import 'package:evently/autoritation/login/redister/register.dart';
import 'package:evently/splashScreen.dart/splashscreen.dart';

import 'package:flutter/widgets.dart';

class RoutManager {
  static const homescreen = "/home";
  static const loginScreen = "/loginScreen";
  static const profiltaps = "/profil_taps";
  static const forgetPassword = "/forgetPassword";
  static const register = "/register";
  static const addevent = "/addevent";
  static const splashscreen = "/splashscreen";
  static Map<String, WidgetBuilder> routes = {
    homescreen: (context) => Home(),
    profiltaps: (context) => Profiletabs(),
    loginScreen: (context) => Loginscreen(),
    register: (context) => Register(),
    addevent: (context) => Addevent(),
    forgetPassword: (context) => const Forgetpassword(),
    splashscreen: (context) => Splashscreen(),
  };
}
