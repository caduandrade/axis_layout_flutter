import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(child: Column(children: [])),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(right: BorderSide(color: Colors.grey[700]!, width: 2))));
  }
}
