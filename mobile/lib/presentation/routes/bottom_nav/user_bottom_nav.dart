import 'package:charge_station_finder/application/admin/admin_bloc.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_add_users.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_home_page.dart';
import 'package:charge_station_finder/presentation/pages/home/home.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../pages/create_station/createStation.dart';

class BottomNavUserPage extends StatefulWidget {
   static const String route = "/user_bottom_nav";

  List<Widget> pages = [
    const HomePage(),
    const ProfilePage()
  ];
  int index = 0;

  void onTap(int index) {
    this.index = index;
  }

  BottomNavUserPage({super.key});

  @override
  State<BottomNavUserPage> createState() => _BottomNavUserPageState();
}

class _BottomNavUserPageState extends State<BottomNavUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: widget.pages[widget.index],
      bottomNavigationBar: BottomNavigationBar(
        
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
