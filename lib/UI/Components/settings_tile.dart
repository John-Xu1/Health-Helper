import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  IconData icon;
  String title;
  Function onPressed;

  SettingsTile({this.icon, this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              height: 2,
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(icon),
            title: Text(title),
          ),
        ],
      ),
    );
  }
}
