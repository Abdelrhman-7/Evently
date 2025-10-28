import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/Apptheam/apptheam.dart';
import 'package:evently/Home/AddEvent/addEvent.dart';
import 'package:evently/Home/Tabs/widget/forgetPassword/forgetPassword.dart';
import 'package:evently/Home/home.dart';
import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/autoritation/login/loginScreen.dart';
import 'package:evently/autoritation/login/redister/register.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/eventListProvider.dart';
import 'package:evently/providers/provider_language.dart';
import 'package:evently/splashScreen.dart/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseFirestore.instance.disableNetwork(); //offline
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderLanguage()),
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => Eventlistprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<ProviderLanguage>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        RoutManager.homescreen: (context) => Home(),
        RoutManager.loginScreen: (context) => Loginscreen(),
        RoutManager.register: (context) => Register(),
        RoutManager.forgetPassword: (context) => Forgetpassword(),
        RoutManager.addevent: (context) => Addevent(),
        RoutManager.splashscreen: (context) => Splashscreen(),
      },
      initialRoute: RoutManager.homescreen,
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheam.lightTheme,
      darkTheme: AppTheam.darkTheme,
      themeMode: themeProvider.appTheme,
      // home: const Home(),
    );
  }
}
