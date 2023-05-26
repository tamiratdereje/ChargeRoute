import 'package:charge_station_finder/presentation/pages/core/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/admin/admin_bloc.dart';
import '../../../domain/admin/admin_model.dart';
import '../../routes/routes.dart';
import '../core/widgets/formField.dart';
import '../core/widgets/primaryButton.dart';
import '../create_station/widgets/inputFieldHeader.dart';

class AdminAddUser extends StatefulWidget {
  const AdminAddUser({super.key});

  @override
  State<AdminAddUser> createState() => _AdminAddUserState();
}

class _AdminAddUserState extends State<AdminAddUser> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _roleController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(

      listener: (context, state) {
        
        if (state is AdminSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User Added Successfully"),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRoutes.BOTTOMNAVADMINPAGE);

        } else if (state is AdminFailureState) {
          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${state.error}User Added Failed"),
              backgroundColor: Colors.red,
            ),
          );}

      },
      child: Scaffold(
          appBar: CHSAppBar.build(context, "Add Users", () {}, true),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const InputFieldHeader(
                  text: "Full Name",
                ),
                CSFFormField(
                    hintText: "Yeab Solomon",
                    onChanged: (value) {
                      setState(() {
                        _fullNameController.text = value;
                      });
                    }),
                const InputFieldHeader(
                  text: "Email",
                ),
                CSFFormField(
                    hintText: "yeab@gmail.com",
                    onChanged: (value) {
                      setState(() {
                        _emailController.text = value;
                      });
                    }),
                const InputFieldHeader(
                  text: "Role",
                ),
                CSFFormField(
                    hintText: "User or Provider",
                    onChanged: (value) {
                      setState(() {
                        _roleController.text = value;
                      });
                    }),
                const InputFieldHeader(
                  text: "Password",
                ),
                CSFFormField(
                    hintText: "yeab1234",
                    onChanged: (value) {
                      setState(() {
                        _passwordController.text = value;
                      });
                    }),
                const SizedBox(
                  height: 40,
                ),
                PrimaryButton(
                    text: "Create",
                    onPressed: () {
                      
    
                      BlocProvider.of<AdminBloc>(context).add(AdminCreateUserEvent(
                        adminDomain: AdminDomain(
                            email: _emailController.text,
                            name: _fullNameController.text,
                            role: _roleController.text,
                            password: _passwordController.text),
                      ));
                    })
                    
              ]),
            ),
          ),
        ),
    );
  }
}
