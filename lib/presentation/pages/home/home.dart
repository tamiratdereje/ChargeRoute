import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/nearby_header.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/searchField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var cards = const <Widget>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CHSAppBar.build(context, "Home", () {}, false),
      body: Column(
        children: [
          const SearchField(),
          const NearbyHeader(),
          ListView.builder(
            itemBuilder: (context, index) => cards[index],
            itemCount: cards.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ],
      ),
    );
  }
}
