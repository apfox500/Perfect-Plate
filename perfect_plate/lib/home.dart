import 'package:flutter/material.dart';
import 'bottom_buttons.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  //TODO: make a DateTime parameter(probably called date)
  const HomePage(this.global, {Key? key}) : super(key: key);
  final Global global;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Global global = widget.global;
    //meal:[[food1 name, food1 calories], [food2 name, food2 calories]]
    Map<String, List<dynamic>> meals = global.calories[global.currentDate]![2] as Map<String, List<dynamic>>;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FooterButtons(global, page: "Home"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_left,
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        global.currentDate,
                      ),
                      Text(
                          "${global.calories[global.currentDate]![1] - global.calories[global.currentDate]![0]} cal remaining")
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_right,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                width: MediaQuery.of(context).size.width * .9,
                child: ListView.builder(
                    itemCount: meals.keys.length,
                    itemBuilder: (context, index) {
                      String mealName = meals.keys.toList()[index];
                      return Column(
                        children: <Widget>[
                              Text(
                                mealName,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ] +
                            (meals[mealName]!).map((dynamic food) {
                              //food is [food name, calories, carbs, fats, protien]
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(food[0]),
                                  Text(food[1].toString()),
                                ],
                              );
                            }).toList(),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nameController = TextEditingController();
          final calController = TextEditingController();
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    //TODO add in meal selection(DropDownButton?)
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        label: Text("Name of food"),
                        hintText: "ex. carrots",
                      ),
                      onSubmitted: (nameFood) {
                        addFood(nameFood, int.parse(calController.text), meals, global);
                        Navigator.pop(context);

                        setState(() {});
                      },
                    ),
                    TextField(
                        controller: calController,
                        decoration: const InputDecoration(
                          label: Text("Number of calories"),
                          hintText: "ex. 70",
                        ),
                        onSubmitted: (numCals) {
                          addFood(nameController.text, int.parse(numCals), meals, global);
                          //global.calories += int.parse(numCals);
                          Navigator.pop(context);
                          setState(() {});
                        }),
                    //TODO: add in the three macro nutrients(carbs, fats, and proteins)
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

void addFood(String name, int calories, Map<String, List<dynamic>> meals, Global global) {
  meals["breakfast"]!.add([name, calories]);
  global.calories[global.currentDate]![0] += calories;
}
