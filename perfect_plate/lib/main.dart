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
        colorSchemeSeed: Colors.purple, //TODO: Pick some colors for the app ryan!
        brightness: Brightness.light,
        //Probably will mostly be done by Ryan
      ),
      darkTheme: ThemeData(
        //dark theme
        colorSchemeSeed: Colors.purple, //TODO: Pick some colors for the app ryan!
        brightness: Brightness.dark,
        //Probably will mostly be done by Andrew
      ),

      //TODO: there should be a date added in here, you can use DateTime.now() to get today's date
      home: HomePage(global),
      debugShowCheckedModeBanner: false,
      //debugShowMaterialGrid: true,
    );
  }
}

//This little handydandy function will compare dates only and not time when you use date1.isSameDate(date2)
extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
