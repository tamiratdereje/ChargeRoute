import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminAddRole extends StatefulWidget {
  const AdminAddRole({super.key});

  @override
  State<AdminAddRole> createState() => _AdminAddRoleState();
}

class _AdminAddRoleState extends State<AdminAddRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CHSAppBar.build(context, "Add Roles", () {}, false),
      body: const Center(
        child: Text("Admin Add Roles Page"),
      ),
    );
  }
}