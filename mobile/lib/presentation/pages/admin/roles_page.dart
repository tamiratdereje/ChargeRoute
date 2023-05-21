
import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({super.key});

  @override
  State<RolesPage> createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CHSAppBar.build(context, "Roles", () {}, false),
      body: const Center(
        child: Text("List of Roles"),
      ),
    );
  }
}