import 'package:flutter/material.dart';

import 'global.dart';
import 'home.dart';

//TODO: find a background
//TODO: make the settings page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Instantiate global
    Global global = Global();

    global.calories[DateTime.now().toFormattedString()] = [
      0,
      2300,
      {
        "breakfast": [],
        "lunch": [],
        "dinner": [],
        "snacks": [],
      }
    ];
    //actually start app
    return MaterialApp(
      theme: ThemeData(
        //light theme
        colorSchemeSeed: Colors.blueGrey, //TODO: Pick some colors for the app ryan!
        brightness: Brightness.light,
        //Probably will mostly be done by Ryan
      ),
      darkTheme: ThemeData(
        //dark theme
        colorSchemeSeed: Colors.amber,
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

extension ToString on DateTime {
  String toFormattedString() {
    return "$month/$day"; //returns MM/DD
  }
}
