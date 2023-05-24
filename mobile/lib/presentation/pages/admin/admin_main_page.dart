import 'package:charge_station_finder/presentation/pages/admin/admin_add_users.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_home_page.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  List<Widget> pages = [
    const AdminHomePage(),
    const AdminAddUser(),
    const ProfilePage(),
  ];
  int index = 0;

  void onTap(int index) {
    this.index = index;
  }

  AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: widget.pages[widget.index],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'All Users',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded), label: 'Add Users'),
         
          BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline), label: 'Profile'),
          
        ],
        currentIndex: widget.index,
        selectedItemColor: Colors.black,
        showSelectedLabels: true,
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        selectedIconTheme: const IconThemeData(color: Colors.black),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,

        onTap: (int i) {
          setState(() {
            widget.index = i;
          });
        },

      ),
    );
  }
}
