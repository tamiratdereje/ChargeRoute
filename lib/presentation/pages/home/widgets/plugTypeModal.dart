// dialog box for selecting plug type

import 'package:flutter/material.dart';


class PlugTypeModal extends StatefulWidget {
  @override
  _PlugTypeModalState createState() => _PlugTypeModalState();
}

class _PlugTypeModalState extends State<PlugTypeModal> {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      children: [Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(children: [
              // title
              const Text(
                'Select Plug Type',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              // content radio buttons with label
              Row(
                children: [
                  Radio(
                    value: 1,
                    groupValue: 1,
                    onChanged: (value) {},
                  ),
                  const Text('Type 1'),
                ],
              ),
              Row(
                children: [
                  Radio(
                    value: 2,
                    groupValue: 1,
                    onChanged: (value) {},
                  ),
                  const Text('Type 2'),
                ],
              ),
              
            ]),
        )],
      ),]
    );
  }
}