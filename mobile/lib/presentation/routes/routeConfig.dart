import 'package:charge_station_finder/application/auth/auth_bloc.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_add_users.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_home_page.dart';
import 'package:charge_station_finder/presentation/pages/auth/signIn.dart';
import 'package:charge_station_finder/presentation/pages/auth/signUp.dart';
import 'package:charge_station_finder/presentation/pages/create_station/createStation.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:charge_station_finder/presentation/pages/station_detail/station_detail.dart';
import 'package:charge_station_finder/presentation/routes/bottom_nav/bottom_nav_page.dart';
import 'package:charge_station_finder/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav/admin_bottom_nav.dart';

class RouterMain extends StatelessWidget {
  final AuthenticationBloc authBloc;
  late final GoRouter _router;

  String? redirector(state) {
    debugPrint('redirector: ${state.location}');
    final authState = authBloc.state;

    const unauthenticatedRoutes = [
      AppRoutes.Login,
      AppRoutes.SignUp,
    ];

    const userOnlyRoutes = [
      AppRoutes.Profile,
      AppRoutes.EditProfile,
      AppRoutes.StationDetails,
      AppRoutes.UserAndProviderHomePage
    ];

    const providerOnlyRoutes = [AppRoutes.AddStation, ...userOnlyRoutes];
    debugPrint(authState.toString());
    if (authState is AuthenticationStateUnauthenticated) {
      if (unauthenticatedRoutes.contains(state.location)) {
        return null;
      }
      return AppRoutes.Login;
    } else if (authState is AuthenticationStateUserAuthenticated) {
      if (userOnlyRoutes.contains(state.location)) {
        return null;
      }
      if (state.location == AppRoutes.Home) {
        return AppRoutes.UserAndProviderHomePage;
      }
      return AppRoutes.UserAndProviderHomePage;
    } else if (authState is AuthenticationStateProviderAuthenticated) {
      if (providerOnlyRoutes.contains(state.location)) {
        return null;
      }
      if (state.location == AppRoutes.Home) {
        return AppRoutes.UserAndProviderHomePage;
      }
      return AppRoutes.UserAndProviderHomePage;
    }
    return null;
  }

  RouterMain({required this.authBloc, Key? key}) : super(key: key) {
    _router = GoRouter(
      redirect: (context, state) => redirector(state),
      initialLocation: AppRoutes.Home,
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.AdminHomePage,
          pageBuilder: (context, state) =>
              const MaterialPage(child: AdminHomePage()),
        ),
        GoRoute(
          path: AppRoutes.AdminAddUsers,
          pageBuilder: (context, state) =>
              const MaterialPage(child: AdminAddUser()),
        ),
        GoRoute(
          path: AppRoutes.Profile,
          pageBuilder: (context, state) =>
              const MaterialPage(child: ProfilePage()),
        ),
        GoRoute(
          path: AppRoutes.AdminHomePage,
          pageBuilder: (context, state) =>
              MaterialPage(child: BottomNavAdminPage()),
        ),
        GoRoute(
          path: AppRoutes.Login,
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignIn());
          },
        ),
        GoRoute(
          path: AppRoutes.SignUp,
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignUp());
          },
        ),
        GoRoute(
          path: AppRoutes.AddStation,
          pageBuilder: (context, state) {
            return const MaterialPage(child: CreateStation());
          },
        ),
        GoRoute(
          path: AppRoutes.StationDetails,
          pageBuilder: (context, state) {
            return const MaterialPage(child: StationDetail());
          },
        ),
        GoRoute(
          path: AppRoutes.UserAndProviderHomePage,
          pageBuilder: (context, state) {
            return MaterialPage(child: BottomNavPage());
          },
        ),
        
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // routerDelegate: _router.routerDelegate,
      // routeInformationParser: _router.routeInformationParser,
      title: 'Charge Station Finder',
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }
}
