// alert dialog

import 'package:flutter/material.dart';

class CRAlert extends StatefulWidget {
  final Function onPressed;
  final String content;
  const CRAlert({super.key, required this.onPressed, required this.content});

  @override
  State<CRAlert> createState() => _CRAlertState();
}

class _CRAlertState extends State<CRAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Are you sure?'),
      content: Text(widget.content),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              'No',
              style: TextStyle(color: Colors.redAccent),
            )),
        TextButton(
            onPressed: () {
              widget.onPressed(context);
            },
            child: const Text('Yes'))
      ],
    );
  }
}
