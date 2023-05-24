import 'package:charge_station_finder/domain/admin/admin_model.dart';
import 'package:charge_station_finder/presentation/pages/admin/admin_edit_users.dart';
import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/admin/admin_bloc.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  final int index = 0;

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CHSAppBar.build(context, "All Users", () {}, false),
        body: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return UserCard(
                adminDomain:
                    AdminDomain(email: "email", name: "alalalal", role: "role"),
                onEdit: (value) {
                  BlocProvider.of<AdminBloc>(context).add(AdminUpdateUserEvent(
                      adminDomain: value));
                },
                onDelete: () {},
              );
            }));
  }
}

class UserCard extends StatelessWidget {
  final AdminDomain adminDomain;
  final Function(AdminDomain adminDomain) onEdit;
  final Function onDelete;

   UserCard(
      {required this.adminDomain,
      required this.onEdit,
      required this.onDelete,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(
          color: const Color.fromARGB(255, 237, 236, 236),
          width: 1,
        ),
      ),
      child:  Row(
        children: [
          const CircleAvatar(
            child: Text("Y"),
          ),
          const SizedBox(
            width: 30,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Yeab solomon"),
              SizedBox(height: 13,),
              Text("Provider"),
            ],
          ),

          const Spacer(flex: 1,),
          Column(children: [

            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.edit, size: 15,),
              onPressed: () async {

                AdminDomain adminDomain_ =
                      (await showModalBottomSheet<AdminDomain?>(
                    isScrollControlled: true,
                    backgroundColor:Colors.black.withOpacity(0.5) ,
                    context: context,
                    builder: (BuildContext context) {
                      return AdminUpdateUserPage(
                        previousEmail: adminDomain.email,
                        previousName: adminDomain.name,
                        previousRole: adminDomain.role,
                          );
                    },
                  ))!;

                  onEdit(adminDomain_);
              },
            ),
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.delete, size: 15,),
              onPressed: () {},
            )
          
          ],)
        ],
      ),
    );
  }
}
