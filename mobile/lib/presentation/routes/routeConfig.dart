import 'package:charge_station_finder/application/admin/admin_bloc.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_add_users.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_edit_users.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_home_page.dart';
import 'package:charge_station_finder/presentation/pages/home/home.dart';
import 'package:charge_station_finder/presentation/pages/profile/profile.dart';
import 'package:charge_station_finder/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../application/auth/auth_bloc.dart';

class RouterMain extends StatelessWidget {
  // final AuthBloc authenticationBloc;
  final AdminBloc adminBloc;
  late final GoRouter _router;
  String? redirector(state) {
    return null;
  }

  RouterMain({required this.adminBloc, Key? key}) : super(key: key) {
    _router = GoRouter(
      redirect: (context, state) => redirector(state),

      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.ADMINHOMEPAGE,
          pageBuilder: (context, state) =>
              const MaterialPage(child: AdminHomePage()),
        ),
        GoRoute(
          path: AppRoutes.ADMINADDUSERS,
          pageBuilder: (context, state) =>
              const MaterialPage(child: AdminAddUser()),
        ),
        GoRoute(
          path: AppRoutes.PROFILE,
          pageBuilder: (context, state) =>
              const MaterialPage(child: ProfilePage()),
        ),

        // GoRoute(
        //   path: AppRoutes.ADMINEDITUSERS,
        //   pageBuilder: (context, state) =>
        //       const MaterialPage(child: AdminUpdateUserPage()),
        // )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        title: 'Charge Station Finder',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}
