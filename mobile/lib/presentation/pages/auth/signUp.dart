import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../domain/auth/models/signUpForm.dart';
import '../../routes/routes.dart';
import '../core/widgets/appBar.dart';
import '../core/widgets/formField.dart';
import '../core/widgets/primaryButton.dart';
import '../create_station/widgets/inputFieldHeader.dart';

class SignUp extends StatefulWidget {
  static const String route = "/signUp";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          } else if (state is AuthenticationStateLoadedNoReturns) {
            const snackBar = SnackBar(
                backgroundColor: Colors.green, content: Text('Success'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
        },
        child: Scaffold(
          appBar: CHSAppBar.build(context, "Sign Up", () {}, false),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputFieldHeader(
                      text: "Name",
                    ),
                    CSFFormField(
                      hintText: "Name",
                      onChanged: () {},
                      obscureText: false,
                      controller: nameController,
                    ),
                    const InputFieldHeader(text: "Email"),
                    CSFFormField(
                      hintText: "Email",
                      onChanged: () {},
                      obscureText: false,
                      controller: emailController,
                    ),
                    const InputFieldHeader(
                      text: "Password",
                    ),
                    CSFFormField(
                      hintText: "Password",
                      onChanged: () {},
                      obscureText: true,
                      controller: passwordController,
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                    PrimaryButton(text: "Sign Up", onPressed: dispatchSignUp),
                    SizedBox(
                      height: 20,),
                    Center(
                      child: GestureDetector(child: Text('Login'), onTap: () {
                        context.go(AppRoutes.Login);
                      }),
                    )
                  ]),
            ),
          ),
        ));
  }

  void dispatchSignUp() {
    context.read<AuthenticationBloc>().add(SignUpEvent(
        signUpForm: SignUpForm(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text)));
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
