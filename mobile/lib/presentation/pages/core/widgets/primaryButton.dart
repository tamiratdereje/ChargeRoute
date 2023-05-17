// elevated button with color and action
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function onPressed;
  const PrimaryButton(
      {super.key,
      required this.text,
      this.color = Colors.black,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () => onPressed(),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
