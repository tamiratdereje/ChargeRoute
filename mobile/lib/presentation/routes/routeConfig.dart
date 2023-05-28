import 'dart:math';

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

    const adminOnlyRoutes = [
      AppRoutes.AdminHomePage,
      AppRoutes.AdminAddUsers,
    ];

    const providerOnlyRoutes = [AppRoutes.AddStation, ...userOnlyRoutes];

   
   if (authState is AuthenticationStateUnauthenticated) {
      if (unauthenticatedRoutes.contains(state.location)) {
        return null;
      }
      return AppRoutes.Login;
    }
    if (authState is AuthenticationStateUserAuthenticated) {
      if (state.location == AppRoutes.Home ||
          state.location == AppRoutes.Login) {
        return AppRoutes.UserAndProviderHomePage;
      }
      return null;
    } else if (authState is AuthenticationStateProviderAuthenticated) {
      if (state.location == AppRoutes.Home ||
          state.location == AppRoutes.Login) {
        return AppRoutes.UserAndProviderHomePage;
      }
      return null;
    } else if (authState is AuthenticationStateAdminAuthenticated) {
      if (state.location == AppRoutes.AdminHomePage ||
          state.location == AppRoutes.Login) {
        return AppRoutes.AdminHomePage;
      }
      return null;
    }
    return null;
  }

  RouterMain({required this.authBloc, Key? key}) : super(key: key) {
    _router = GoRouter(
      redirect: (context, state) => redirector(state),
      initialLocation: AppRoutes.Login,
      routes: <GoRoute>[
        
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
          name: AppRoutes.AddStation,
          path: AppRoutes.AddStation,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: CreateStation(
              id: state.queryParameters["id"],
            ));
          },
        ),
        GoRoute(
          path: AppRoutes.StationDetails,
          name: AppRoutes.StationDetails,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: StationDetail(id: state.queryParameters["id"]!));
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
