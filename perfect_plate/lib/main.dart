import 'package:flutter/material.dart';

import 'global.dart';
import 'home.dart';

//TODO: find a background

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Instantiate global
    Global global = Global();
    //actually start app
    return MaterialApp(
      theme: ThemeData(
        //light theme
        colorSchemeSeed: Colors.purple, //TODO: Pick some colors for the app!
        brightness: Brightness.light,
        //Probably will mostly be done by Ryan
      ),
      darkTheme: ThemeData(
        //dark theme
        colorSchemeSeed: Colors.purple, //TODO: Pick some colors for the app!
        brightness: Brightness.dark,
        //Probably will mostly be done by Andrew
      ),
      home: HomePage(global),
      debugShowCheckedModeBanner: false,
      //debugShowMaterialGrid: true,
    );
  }
}
