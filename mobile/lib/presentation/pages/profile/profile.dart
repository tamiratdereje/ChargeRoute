// profile page

import 'dart:io';

import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:charge_station_finder/presentation/pages/create_station/widgets/inputFieldHeader.dart';
import 'package:charge_station_finder/presentation/pages/profile/widgets/alertDialog.dart';
import 'package:charge_station_finder/presentation/pages/profile/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../routes/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (_, state) {
      if (state is AuthenticationStateError) {
        final snackBar = SnackBar(
          content: Text(state.message!),
          backgroundColor: Colors.redAccent,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (state is AuthenticationStateAuthenticated) {
        const snackBar =
            SnackBar(backgroundColor: Colors.green, content: Text('Success'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (state is LogoutSucceed || state is DeleteAccountSucceed) {
        context.go(AppRoutes.Login);
      } else if (state is AuthenticationLoading) {
        const loading = SnackBar(
            content: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ));
        ScaffoldMessenger.of(context).showSnackBar(loading);
      }
    }, child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (builder, state) {
        return (state is AuthenticationStateAuthenticated)
            ? Scaffold(
                appBar: CHSAppBar.build(context, "Profile", () {}, false),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const InputFieldHeader(text: "Information"),
                        ProfileTile(
                          enabled: false,
                          icon: Icon(Icons.person),
                          text: 'Name',
                          onPressed: () {},
                          trailingText: (state).userData!.user.name,
                        ),
                        ProfileTile(
                            enabled: false,
                            icon: Icon(Icons.email),
                            text: "Email",
                            onPressed: () {},
                            trailingText: (state).userData!.user.email),
                        ProfileTile(
                            enabled: false,
                            icon: Icon(Icons.account_circle),
                            text: "Role",
                            onPressed: () {},
                            trailingText: (state).userData!.user.role),
                        const SizedBox(
                          height: 16,
                        ),
                        const InputFieldHeader(text: "Edit Profile"),
                        ProfileTile(
                            enabled: true,
                            icon: Icon(Icons.password),
                            text: "Change Password",
                            onPressed: () {},
                            trailingText: ""),
                        state is LoggingOut
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ProfileTile(
                                enabled: true,
                                icon: Icon(Icons.logout),
                                text: "Logout",
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => CRAlert(
                                          onPressed: dispatchLogoutEvent,
                                          content:
                                              "Are you sure you want to logout?"));
                                },
                                trailingText: ""),
                        state is DeletingAccount
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ProfileTile(
                                color: Colors.redAccent,
                                enabled: true,
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.redAccent,
                                ),
                                text: "Delete Account",
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => CRAlert(
                                          onPressed: dispatchDeleteAccountEvent,
                                          content:
                                              "Are you sure you want to delete your account?"));
                                },
                                trailingText: ""),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: CHSAppBar.build(context, "Profile", () {}, false),
                body: const Center(
                  child: Text("Please login to view your profile"),
                  
                  
                ),
              );
      },
    ));
  }

  void dispatchLogoutEvent(BuildContext context) {
    context.read<AuthenticationBloc>().add(LogoutEvent());
  }

  void dispatchDeleteAccountEvent(BuildContext context) {
    context.read<AuthenticationBloc>().add(DeleteAccountEvent());
  }
}
