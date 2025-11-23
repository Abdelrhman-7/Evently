import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/core/assetsmanager.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/providers/app_theme_provider.dart';
import 'package:evently/providers/provider_language.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Personalize Your Experience",
      "desc":
          "Choose your preferred theme and language to\n get started with a comfortable, tailored\n experience that suits your style.",
      "image": ImageAssets.oncordingone,
    },
    {
      "title": "Find Events That Inspire You",
      "desc":
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone.",
      "image": ImageAssets.oncordingtow,
    },
    {
      "title": "Effortless Event Planning",
      "desc":
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered.",
      "image": ImageAssets.oncordingthree,
    },
    {
      "title": "Connect with Friends & Share Moments",
      "desc":
          "Make every event memorable by sharing the experience with others. Invite friends, keep everyone in the loop, and celebrate moments together.",
      "image": ImageAssets.oncordingfoure,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<AppThemeProvider>(context);
    final languageProvider = Provider.of<ProviderLanguage>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.08),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: Image.asset(ImageAssets.onbordinglogo)),
                          SizedBox(height: height * 0.02),
                          Center(
                            child: Image.asset(onboardingData[index]["image"]!),
                          ),
                          SizedBox(height: height * 0.05),
                          Text(
                            onboardingData[index]["title"]!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).canvasColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: height * 0.03),
                          Text(
                            onboardingData[index]["desc"]!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).disabledColor,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          if (index == 0) ...[
                            const SizedBox(height: 20),
                            Text(
                              "Language",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            DropdownButton<String>(
                              value: languageProvider.appLanguage,
                              items: [
                                DropdownMenuItem(
                                  value: 'en',
                                  child: Text(
                                    "English",
                                    style: TextStyle(
                                      color: Theme.of(context).disabledColor,
                                    ),
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'ar',
                                  child: Text(
                                    "العربية",
                                    style: TextStyle(
                                      color: Theme.of(context).disabledColor,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (newLang) {
                                languageProvider.changeLanguage(newLang!);
                              },
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Theme",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).disabledColor,
                              ),
                            ),
                            SwitchListTile(
                              title: Text(
                                "Dark Mode",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).disabledColor,
                                ),
                              ),
                              value: themeProvider.isDarkMode(),
                              onChanged: (val) {
                                themeProvider.changeThemeMode(
                                  val ? ThemeMode.dark : ThemeMode.light,
                                );
                              },
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: currentIndex == index ? 16 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: currentIndex == index
                        ? Colormanager.blue
                        : Colors.grey[400],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (currentIndex == 0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colormanager.purple,
                    ),
                    onPressed: () {
                      _controller.jumpToPage(1);
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 16, color: Colormanager.white),
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Theme.of(context).canvasColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).canvasColor,
                        ),
                        onPressed: () {
                          if (currentIndex > 1) {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Theme.of(context).canvasColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).canvasColor,
                        ),
                        onPressed: () {
                          if (currentIndex == onboardingData.length - 1) {
                            Navigator.pushReplacementNamed(
                              context,
                              RoutManager.loginScreen,
                            );
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
