import 'dart:async';

import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed(RoutManager.onbording);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Center(
                child: Image.asset(ImageAssets.splash, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Image.asset(
                ImageAssets.splashlogo,
                height: 80,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
