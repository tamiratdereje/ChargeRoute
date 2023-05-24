// profile page

import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:charge_station_finder/presentation/pages/create_station/widgets/inputFieldHeader.dart';
import 'package:charge_station_finder/presentation/pages/profile/widgets/alertDialog.dart';
import 'package:charge_station_finder/presentation/pages/profile/widgets/profileTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (_, state) {
          if (state is Error) {
            final snackBar = SnackBar(
              content: Text(state.message!),
              backgroundColor: Colors.redAccent,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is Loaded) {
            const snackBar = SnackBar(
                backgroundColor: Colors.green, content: Text('Success'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else if (state is AuthenticationLoading) {
            const loading = SnackBar(
                content: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ));
            ScaffoldMessenger.of(context).showSnackBar(loading);
          }
        },
      child: Scaffold(
      appBar: CHSAppBar.build(context, "Profile", () {}, true),
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
                text: "Name",
                onPressed: () {},
                trailingText: "John Doe",
              ),
              ProfileTile(
                  enabled: false,
                  icon: Icon(Icons.email),
                  text: "Email",
                  onPressed: () {},
                  trailingText: "john@gmail.com"),
              ProfileTile(
                  enabled: false,
                  icon: Icon(Icons.phone),
                  text: "Phone",
                  onPressed: () {},
                  trailingText: "+91 9876543210"),
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
              ProfileTile(
                  enabled: true,
                  icon: Icon(Icons.logout),
                  text: "Logout",
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => CRAlert(
                            onPressed: dispatchLogoutEvent,
                            content: "Are you sure you want to logout?"));
                  },
                  trailingText: ""),
              ProfileTile(
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
    ));
  }

  void dispatchLogoutEvent(BuildContext context) {
    context.read<AuthenticationBloc>().add(LogoutEvent());
    Navigator.pop(context);
  }

  void dispatchDeleteAccountEvent(BuildContext context) {
    context.read<AuthenticationBloc>().add(DeleteAccountEvent());
    Navigator.pop(context);
  }
}
