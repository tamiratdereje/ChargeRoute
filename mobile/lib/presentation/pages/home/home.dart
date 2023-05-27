import 'package:charge_station_finder/application/home/home_bloc.dart';
import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/charger_tile.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/filter_dialog.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/nearby_header.dart';
import 'package:charge_station_finder/presentation/pages/home/widgets/searchField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  static const String route = "/home";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var queryText = "";
  var minWattage = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CHSAppBar.build(context, "Home", () {}, false),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          body: Column(
            children: [
              SearchField(
                onSearchSubmit: (query) {
                  queryText = query;
                  context
                      .read<HomeBloc>()
                      .add(HomeEventSearchSubmit(query, minWattage));
                },
                onShowFilterDialog: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (context) => FilterDialog(
                      onFilterSubmit: (double minWattage) {
                        this.minWattage = minWattage;
                        context
                            .read<HomeBloc>()
                            .add(HomeEventSearchSubmit(queryText, minWattage));
                      },
                    ),
                  );
                },
              ),
              const NearbyHeader(),
              Expanded(
                child: () {
                  if (state is HomeStateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomeStateInitial) {
                    return const Center(
                      child: Text(
                        "Search results will appear here",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  } else if (state is HomeStateSuccess &&
                      state.results.isEmpty) {
                    return const Center(
                      child: Text(
                        "No results found",
                        style: TextStyle(fontSize: 20),
                      ),
                    );
                  } else if (state is HomeStateSuccess) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ChargerTile(
                          name: state.results[index].name,
                          address: state.results[index].address,
                          rating: state.results[index].rating,
                          wattage: state.results[index].wattage,
                        );
                      },
                      itemCount: state.results.length,
                      shrinkWrap: true,
                    );
                  } else if (state is HomeStateError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            size: 50,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            state.message,
                            style: const TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(
                    child: Text(
                      "Unknown state",
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }(),
              ),
            ],
          ),
        );
      },
    );
  }
}
