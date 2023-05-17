// list Tile for profile page

import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function onPressed;
  final String trailingText;
  final bool enabled;
  final Color color;
  const ProfileTile(
      {super.key,
      this.color = Colors.black,
      required this.enabled,
      required this.icon,
      required this.text,
      required this.onPressed,
      required this.trailingText});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(12),
      tileColor: Colors.grey[200],
      enabled: enabled,
      leading: icon,
      title: Text(text, style: TextStyle(color: color),),
      trailing: Text(
        trailingText,
        style: TextStyle(fontSize: 14),
      ),
      onTap: () => onPressed(),
    );
  }
}
