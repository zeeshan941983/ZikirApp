import 'package:al_zikr/Home.dart';
import 'package:al_zikr/Tasbeeh.dart';
import 'package:al_zikr/RoomMain.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 1;

  final screen = [
    const HomeScreen(),
    const TasbeehScreen(),
    const RoomMainScreen(),
  ];
  List<Widget> icons = [
    const Icon(Icons.home),
    const Icon(Icons.format_list_numbered_rtl),
    const Icon(Icons.countertops),
  ];
  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      body: screen[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: const IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          items: icons,
          index: _selectedIndex,
          color: const Color(0xff102C57),
          backgroundColor: Colors.white,
          onTap: (value) => setState(() {
            _selectedIndex = value;
          }),
        ),
      ),
    );
  }
}
