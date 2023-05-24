import 'package:charge_station_finder/application/admin/admin_bloc.dart';
import 'package:charge_station_finder/application/home/home_bloc.dart';
import 'package:charge_station_finder/domain/charger/charger_repository_interface.dart';
import 'package:charge_station_finder/utils/custom_http_client.dart';
import 'package:charge_station_finder/presentation/pages/auth/signUp.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'infrastructure/repository/charger_repository_impl.dart';
import 'infrastructure/repository/review_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/auth/auth_bloc.dart';
import 'presentation/pages/auth/signIn.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var httpClient = CustomHttpClient();

    var reviewRepository = ReviewRepositoryImpl(httpClient: httpClient);
    var chargerRepository = ChargerRepositoryImpl(
        httpClient: httpClient, reviewRepository: reviewRepository);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ReviewRepositoryImpl>(
            create: (context) => reviewRepository),
        RepositoryProvider<ChargerRepositoryInterface>(
            create: (context) => chargerRepository),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<HomeBloc>(
              create: (context) =>
                  HomeBloc(chargerRepository: chargerRepository),
            ),
            BlocProvider<AdminBloc>(
              create: (context) => AdminBloc(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.black,
              platform: TargetPlatform.android,
              useMaterial3: true,
            ),
            home: HomePage(),
          )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<Widget> pages = [
    HomePage(),
    const CreateStation(),
    const ProfilePage(),
  ];
  int index = 0;

  void onTap(int index) {
    this.index = index;
  }

  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ProfilePage();
  }
}
