import 'package:flutter/material.dart';

class InputFieldHeader extends StatelessWidget {
  final String text;
  const InputFieldHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ));
  }
}
