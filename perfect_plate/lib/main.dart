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
        "Breakfast": [],
        "Lunch": [],
        "Dinner": [],
        "Snacks": [],
      }
    ];
    //actually start app
    return MaterialApp(
      theme: ThemeData(
        //light theme

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 55, 101, 138),
          brightness: Brightness.light,
        ).copyWith(),
        backgroundColor: const Color.fromARGB(255, 215, 215, 215),
        //Probably will mostly be done by Ryan
      ),
      darkTheme: ThemeData(
        //dark theme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 246, 174, 45),
          brightness: Brightness.dark,
        ).copyWith(),
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
