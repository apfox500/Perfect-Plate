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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: (Theme.of(context).brightness == Brightness.light)
                  ? const Color.fromARGB(255, 51, 101, 138)
                  : const Color.fromARGB(255, 246, 174, 45),
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(blurRadius: 5, spreadRadius: 1),
              ],
              //shape: BoxShape.circle,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    Text(
                      widget.meal ?? "Log Food",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),

          //Dropdown to select the meal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Visibility(
              visible: widget.meal == null,
              child: DropdownButton(
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                label: Text("Name of food"),
                hintText: "ex. carrots",
              ),
              onSubmitted: (nameFood) {
                addFood(meals, global);
              },
            ),
          ),
          //Calories text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
                controller: calController,
                decoration: const InputDecoration(
                  label: Text("Number of calories"),
                  hintText: "ex. 70",
                ),
                onSubmitted: (numCals) {
                  addFood(meals, global);
                }),
          ),
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
    );
  }

  //actual function to add the food to the log
  void addFood(Map<String, List<dynamic>> meals, Global global) {
    if (nameController.text.isEmpty || calController.text.isEmpty) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Empty Fields"),
              content: const Text("Please make sure you filled out all foods"),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text("Ok"),
                ),
              ],
            );
          });
    } else {
      meals[widget.meal ?? mealValue]!.add([nameController.text, int.parse(calController.text)]);
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
