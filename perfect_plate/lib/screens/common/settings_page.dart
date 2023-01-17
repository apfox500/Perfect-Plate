//The user should be able to set the number of calories they want as their goal
//TODO: make the settings page

import 'package:flutter/material.dart';
import 'package:perfect_plate/widgets/bottom_buttons.dart';

import '../../models/global.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage(this.global, {super.key});
  final Global global;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Global global = widget.global;
    return Scaffold(
      bottomNavigationBar: FooterButtons(
        global,
        page: "settings",
      ),
      //let user choose max calories
      body: Column(children: [
        TextField(
          decoration: const InputDecoration(
            label: Text("Calorie Goal"),
          ),
        )
      ]),
    );
  }
}
