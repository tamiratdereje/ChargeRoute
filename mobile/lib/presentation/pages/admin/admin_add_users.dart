import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminAddUser extends StatefulWidget {
  const AdminAddUser({super.key});

  @override
  State<AdminAddUser> createState() => _AdminAddUserState();
}

class _AdminAddUserState extends State<AdminAddUser> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: CHSAppBar.build(context, "Add Users", () {}, false),
      body: const Center(
        child: Text("Add User Page"),
      ),
    );
  }
}