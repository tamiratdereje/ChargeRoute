import 'package:charge_station_finder/presentation/pages/home/home.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  List<Widget> pages = [
    const HomePage(),
    const ProfilePage(),
  ];
  int index = 0;

  void onTap(int index) {
    this.index = index;
  }

  BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.pages[widget.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.index,
        type: BottomNavigationBarType.fixed,
        onTap: (int i) {
          setState(() {
            widget.index = i;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
