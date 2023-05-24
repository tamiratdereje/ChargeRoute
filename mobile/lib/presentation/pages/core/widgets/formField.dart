// input field
import 'package:flutter/material.dart';

class CSFFormField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  const CSFFormField(
      {super.key, required this.hintText, required this.onChanged, });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (FormFieldState state) {
        return TextField(
          decoration: InputDecoration(
            hintStyle: const TextStyle(color: Colors.black26),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: (value) {
            onChanged(value);
          },
        );
      },
    );
  }
}
