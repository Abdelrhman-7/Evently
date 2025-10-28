import 'package:evently/core/colormanager.dart';
import 'package:flutter/material.dart';

class AppTheam {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colormanager.blue,
    scaffoldBackgroundColor: Colormanager.white,
    focusColor: Colormanager.white,
    dividerColor: Colormanager.whitepure,
    disabledColor: Colormanager.black,
    canvasColor: Colormanager.blue,
    cardColor: Color(0xff7B7B7B),

    appBarTheme: AppBarTheme(
      backgroundColor: Colormanager.white,
      foregroundColor: Color(0xff5669FF),

      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,

      selectedItemColor: Colormanager.white,
      unselectedItemColor: Colors.white,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colormanager.blue,
      shape: StadiumBorder(
        side: BorderSide(color: Colormanager.white, width: 6),
      ),
      //or
      /* RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(30),
        side: BorderSide(color: Colormanager.white, width: 6),
      ),*/
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colormanager.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colormanager.darkBlue,
    scaffoldBackgroundColor: Colormanager.darkBlue,
    focusColor: Colormanager.blue,
    dividerColor: Colormanager.darkBlue,
    disabledColor: Colormanager.whitepure,
    canvasColor: Colormanager.blue,
    cardColor: Colormanager.blue,
    appBarTheme: AppBarTheme(
      backgroundColor: Colormanager.darkBlue,
      foregroundColor: Color(0xff5669FF),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,

      //  backgroundColor: Colormanager.darkBlue,
      selectedItemColor: Colormanager.white,
      unselectedItemColor: Colors.grey,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colormanager.darkBlue,
      shape: StadiumBorder(
        side: BorderSide(color: Colormanager.white, width: 6),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colormanager.white,
      ),
    ),
  );
}
