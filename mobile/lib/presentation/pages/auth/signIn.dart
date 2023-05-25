// create station form

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/auth/auth_bloc.dart';
import '../../../domain/auth/models/signInFormForm.dart';
import '../core/widgets/appBar.dart';
import '../core/widgets/formField.dart';
import '../core/widgets/primaryButton.dart';
import '../create_station/widgets/inputFieldHeader.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // global key
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
          } else if (state is UserAuthenticated) {
            const snackBar = SnackBar(
                backgroundColor: Colors.green, content: Text('Success'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          } else if(state is AdminAuthenticated){
            const snackBar = SnackBar(
                backgroundColor: Colors.green, content: Text('Success'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          else if (state is AuthenticationLoading) {
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
          appBar: CHSAppBar.build(context, "Sign In", () {}, false),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InputFieldHeader(
                      text: "Email",
                    ),
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
                    PrimaryButton(text: "Sign In", onPressed: dispatchLogin)
                  ]),
            ),
          ),
        ));
  }

  void dispatchLogin() {
    context.read<AuthenticationBloc>().add(LoginEvent(
        signInForm: SignInForm(
            email: emailController.text, password: passwordController.text)));
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
