import 'package:evently/Home/Tabs/favoritstab.dart';
import 'package:evently/Home/Tabs/hometap.dart';
import 'package:evently/Home/Tabs/profiletabs.dart';
import 'package:evently/Routmanager/routesmanager.dart';
import 'package:evently/core/Icon.dart';
import 'package:evently/core/colormanager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Hometap(),
    const Center(child: Text("Map Page")),
    Favoritstab(),
    const Profiletabs(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SafeArea(
        child: BottomAppBar(
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              buildBottomNavigationBarItem(
                index: 0,
                selectedIndex: IconManager.homeicon,
                unSelectedIndex: IconManager.home,
                label: AppLocalizations.of(context)!.home,
              ),
              buildBottomNavigationBarItem(
                index: 1,
                selectedIndex: IconManager.Map_Pinicon,
                unSelectedIndex: IconManager.Map_Pin,
                label: AppLocalizations.of(context)!.map,
              ),
              buildBottomNavigationBarItem(
                index: 2,
                selectedIndex: IconManager.favoriatsicon,
                unSelectedIndex: IconManager.favoriats,
                label: AppLocalizations.of(context)!.favorites,
              ),
              buildBottomNavigationBarItem(
                index: 3,

                selectedIndex: IconManager.User_01icon,
                unSelectedIndex: IconManager.User_01,
                label: AppLocalizations.of(context)!.profile,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(RoutManager.addevent);
        },
        child: Icon(Icons.add, color: Colormanager.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required String unSelectedIndex,
    required String selectedIndex,
    required int index,
    required String label,
  }) {
    return BottomNavigationBarItem(
      // ignore: unrelated_type_equality_checks
      icon: ImageIcon(
        // ignore: unrelated_type_equality_checks
        AssetImage(_selectedIndex == index ? selectedIndex : unSelectedIndex),
        size: 20,
      ),
      label: label,
    );
  }
}
