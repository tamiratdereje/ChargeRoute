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
    return BlocConsumer<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is AdminSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User Added Successfully"),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is AdminFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.error}User Added Failed"),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is AdminLoadingState){
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Users are loading "),
              backgroundColor: const Color.fromARGB(255, 6, 24, 6),
            ),
          );
        }
      },
      builder: (context, state) {
        
        if (state is AdminSuccessState){

          

          return Scaffold(
            appBar: CHSAppBar.build(context, "All Users", () {}, false),
            body: ListView.builder(
                itemCount: state.adminDomains.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    adminDomain: AdminDomain(
                        email: state.adminDomains[index].email, name: state.adminDomains[index].name, role: state.adminDomains[index].role),
                    onEdit: (value) {
                      BlocProvider.of<AdminBloc>(context)
                          .add(AdminUpdateUserEvent(adminDomain: value));
                    },
                    onDelete: () {},
                  );
                })); 

        } else if (state is AdminLoadingState){
          

          return Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.red, strokeWidth: 5, backgroundColor: Colors.green,),),);

        } else {
          

          return Scaffold(body: Center(child: Text("Error while fetching "),),);
        }
        
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final AdminDomain adminDomain;
  final Function(AdminDomain adminDomain) onEdit;
  final Function onDelete;

  UserCard({
    required this.adminDomain,
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
      child: Row(
        children: [
          const CircleAvatar(
            child: Text("Y"),
          ),
          const SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(adminDomain.name),
              SizedBox(
                height: 13,
              ),
              Text(adminDomain.role),
            ],
          ),
          const Spacer(
            flex: 1,
          ),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.edit,
                  size: 15,
                ),
                onPressed: () async {
                  AdminDomain adminDomain_ =
                      (await showModalBottomSheet<AdminDomain?>(
                    isScrollControlled: true,
                    backgroundColor: Colors.black.withOpacity(0.5),
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
                icon: const Icon(
                  Icons.delete,
                  size: 15,
                ),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}
