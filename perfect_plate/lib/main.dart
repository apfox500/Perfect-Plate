import 'package:flutter/material.dart';
import 'package:perfect_plate/providers/search_food.dart';

import 'models/global.dart';
import 'screens/common/home.dart';
//Switiching to the edamam api
//https://developer.edamam.com/food-database-api
//octet.kumquat_0p@icloud.com
//630fbb8a
//29c54185dc75130fde7b74e60bcb1e88
//https://developer.edamam.com/food-database-api-docs
//This API  will work spectactularley

//Stuff to put when people log their own recipies:
/* How do I get best results in my nutrition analysis?
Always include an ingredient quantity: “3 oz butter cookies” is preferable to “butter cookies or tuiles”
Shorten and simplify the line: “2 cans garbanzo beans, drained” is preferable to “2-2 1/2 cans of washed and drained garbanzo beans”
If oil is used for frying, indicate so in the ingredient line (add the words “for frying”), so we can accurately calculate how much gets absorbed.
For stocks and broths, include “stock” or “broth” in the recipe title, so we can accurately calculate the remaining nutritional value once it’s strained. */

//TODO: find a background
//TODO: make the settings page

void main() async {
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
      //Color should follow a 60/30/10 primery/second/accent rule
      //Accent color: Color.fromARGB(255, 255, 125, 125)
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
