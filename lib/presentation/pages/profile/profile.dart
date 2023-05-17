// profile page

import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:charge_station_finder/presentation/pages/create_station/widgets/inputFieldHeader.dart';
import 'package:charge_station_finder/presentation/pages/profile/widgets/profileTile.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              const SizedBox(height: 16,),
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
                  onPressed: () {},
                  trailingText: ""),
              ProfileTile(
                  color: Colors.redAccent,
                  enabled: true,
                  icon: const Icon(Icons.delete, color: Colors.redAccent,),
                  text: "Delete Account",
                  onPressed: () {},
                  trailingText: ""),
                
            ],
          ),
        ),
      ),
    );
  }
}
