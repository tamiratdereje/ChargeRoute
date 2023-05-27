import 'package:charge_station_finder/application/admin/admin_bloc.dart';
import 'package:charge_station_finder/application/auth/auth_bloc.dart';
import 'package:charge_station_finder/application/create_station/create_station_bloc.dart';
import 'package:charge_station_finder/application/home/home_bloc.dart';
import 'package:charge_station_finder/domain/charger/charger_repository_interface.dart';
import 'package:charge_station_finder/infrastructure/data-source/local/sharedPrefHelper.dart';
import 'package:charge_station_finder/infrastructure/dto/userAuthCredential.dart';
import 'package:charge_station_finder/presentation/pages/auth/signIn.dart';
import 'package:charge_station_finder/presentation/pages/core/splash_screen.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:charge_station_finder/presentation/pages/station_detail/station_detail.dart';
import 'package:charge_station_finder/presentation/routes/app_route.dart';
import 'package:charge_station_finder/presentation/routes/bottom_nav/admin_bottom_nav.dart';
import 'package:charge_station_finder/presentation/routes/bottom_nav/provider_bottom_nav.dart';
import 'package:charge_station_finder/presentation/routes/bottom_nav/user_bottom_nav.dart';
import 'package:charge_station_finder/utils/custom_http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/contracts/IAuthRepository.dart';
import 'infrastructure/repository/authRepository.dart';
import 'infrastructure/repository/charger_repository_impl.dart';
import 'infrastructure/repository/review_repository_impl.dart';
import 'presentation/pages/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final showHome = await ShardPrefHelper.hasOpend();
  final UserData userData = await ShardPrefHelper.getUser();
  final String? token = userData.token;
  final String? role = userData.user.role;
  final bool isLoggedIn = !(token == null);
  runApp(MyApp(showHome: showHome, isLoggedIn: isLoggedIn, role: role));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final bool showHome;
  final String? role;

  const MyApp(
      {required this.showHome,
      required this.isLoggedIn,
      required this.role,
      super.key});

  String? getRoute(bool showHome, role) {
    if (showHome) {
      if (isLoggedIn) {
        if (role == 'user') {
          return BottomNavUserPage.route;
        } else if (role == 'provider') {
          return BottomNavProviderPage.route;
        } else if (role == 'admin') {
          return BottomNavAdminPage.route;
        }
      } else {
        return SignIn.route;
      }
    } else {
      return SplashScreen.route;
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var httpClient = CustomHttpClient();

    var reviewRepository = ReviewRepositoryImpl(httpClient: httpClient);
    var chargerRepository = ChargerRepositoryImpl(
        httpClient: httpClient, reviewRepository: reviewRepository);
    var authenticationRepository =
        AuthenticationRepository(httpClient: httpClient);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ReviewRepositoryImpl>(
            create: (context) => reviewRepository),
        RepositoryProvider<ChargerRepositoryInterface>(
            create: (context) => chargerRepository),
        RepositoryProvider<IAuthenticationRepository>(
          create: (context) => authenticationRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(chargerRepository: chargerRepository),
          ),
          BlocProvider<AdminBloc>(
            create: (context) => AdminBloc()..add(AdminGetUsersEvent()),
          ),
          BlocProvider<AuthenticationBloc>(
              create: (context) =>
                  AuthenticationBloc(authRepository: authenticationRepository)
                    ..add(GetUserAuthCredentialEvent())),
          BlocProvider<CreateStationBloc>(
            create: (context) => CreateStationBloc(chargerRepository),
          )
        ],
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (_, state) {
            // if (state is UserAuthenticated ||
            //     state is AdminAuthenticated ||
            //     state is ProviderAuthenticated) {
            //   httpClient.authToken =
            //       (state as Authenticated).userData!.token;
            // }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primaryColor: Colors.black,
              platform: TargetPlatform.android,
              useMaterial3: true,
            ),
            home: BottomNavAdminPage(),
            initialRoute: getRoute(showHome, role),
            onGenerateRoute: PageRouter.generateRoute,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const route = '/home';
  List<Widget> pages = [
    HomePage(),
    ProfilePage(),
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
    return const HomePage();
  }
}
