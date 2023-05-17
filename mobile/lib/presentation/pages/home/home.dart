import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/charger_tile.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/nearby_header.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/searchField.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CHSAppBar.build(context, "Home", () {}, false),
      body: Column(
        children: [
          const SearchField(),
          const NearbyHeader(),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const ChargerTile();
              },
              itemCount: 10,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
