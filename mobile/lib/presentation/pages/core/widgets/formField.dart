// input field
import 'package:flutter/material.dart';

class CSFFormField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final bool obscureText;
  final TextEditingController controller;
  final Key? formkey;
  const CSFFormField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      required this.obscureText,
      required this.controller,
      this.formkey
    });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return TextField(
          obscureText: obscureText,
          key: formkey,
          controller: controller,
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.black26),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {},
        );
      },
    );
  }
}
