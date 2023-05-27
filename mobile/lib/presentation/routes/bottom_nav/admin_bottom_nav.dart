import 'package:charge_station_finder/application/admin/admin_bloc.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_add_users.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_home_page.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavAdminPage extends StatefulWidget {
   static const String route = "/admin_bottom_nav";

  List<Widget> pages = [
    const AdminHomePage(),
    const AdminAddUser(),
    const ProfilePage(),
  ];
  int index = 0;

  void onTap(int index) {
    this.index = index;
  }

  BottomNavAdminPage({super.key});

  @override
  State<BottomNavAdminPage> createState() => _BottomNavAdminPageState();
}

class _BottomNavAdminPageState extends State<BottomNavAdminPage> {
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

          if (i == 0){
            BlocProvider.of<AdminBloc>(context).add(AdminGetUsersEvent());

          } else if (i == 2) {
            // BlocProvider.of<ProfileBLoc>(context).add(AdminGetUsersEvent());
          }

          setState(() {
            widget.index = i;
          });
          
        },

  
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

      ),
    );
  }
}
