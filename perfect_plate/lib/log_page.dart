import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:perfect_plate/home.dart';

import 'global.dart';

class LogPage extends StatefulWidget {
  const LogPage(this.global, {super.key, this.meal});
  final Global global;
  final String? meal;
  @override
  State<LogPage> createState() => _LogPageState();
}

class _LogPageState extends State<LogPage> {
  String mealValue = "Breakfast";
  final nameController = TextEditingController();
  final calController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Global global = widget.global;
    //meal:[[food1 name, food1 calories], [food2 name, food2 calories]]
    Map<String, List<dynamic>> meals = global.calories[global.currentDate]![2] as Map<String, List<dynamic>>;
    List<String> mealNames = meals.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Food"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //const Text("Log food"),
              //Dropdown to select the meal
              DropdownButton(
                  value: mealValue,
                  items: mealNames.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      mealValue = value!;
                    });
                  }),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text("Name of food"),
                  hintText: "ex. carrots",
                ),
                onSubmitted: (nameFood) {
                  addFood(meals, global);
                },
              ),
              //Calories text field
              TextField(
                  controller: calController,
                  decoration: const InputDecoration(
                    label: Text("Number of calories"),
                    hintText: "ex. 70",
                  ),
                  onSubmitted: (numCals) {
                    addFood(meals, global);
                  }),
              //TODO: add in the three macro nutrients(carbs, fats, and proteins)
              //Submit button
              ElevatedButton(
                onPressed: () {
                  addFood(meals, global);
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }

  //actual function to add the food to the log
  void addFood(Map<String, List<dynamic>> meals, Global global) {
    if (nameController.text.isEmpty || calController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Empty Fields"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok"),
                ),
              ],
            );
          });
    } else {
      meals[mealValue]!.add([nameController.text, int.parse(calController.text)]);
      global.calories[global.currentDate]![0] += int.parse(calController.text);
      setState(() {});
      Navigator.push(
        context,
        PageTransition(
          child: HomePage(global),
          type: PageTransitionType.fade,
        ),
      );
    }
  }
}
