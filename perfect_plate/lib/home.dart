import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:perfect_plate/log_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:perfect_plate/main.dart';

import 'bottom_buttons.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  final Global global;
  const HomePage(this.global, {Key? key}) : super(key: key);
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
      backgroundColor:
          (Theme.of(context).brightness == Brightness.light) ? Theme.of(context).backgroundColor : null,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FooterButtons(global, page: "Home"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
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
                  child: Column(
                    children: [
                      //TODO: add in the logo/Title up here

                      //calories row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          //calories remaining
                          Text(
                            "${global.calories[global.currentDate]![1] - global.calories[global.currentDate]![0]}\ncalories\nremaining",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                          //calories eaten
                          CircularPercentIndicator(
                            radius: 50,
                            percent:
                                global.calories[global.currentDate]![0] / global.calories[global.currentDate]![1],
                            center: Text(
                              "${global.calories[global.currentDate]![0]}",
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            footer: Text(
                              "Calories Eaten",
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            //progressColor: Color.fromARGB(255, 255, 125, 125),
                            linearGradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 125, 125),
                                Color.fromARGB(255, 255, 125, 200),
                              ],
                            ),
                          ),
                          Text(
                            "--\ncalories\nburned", //TODO: calories burned
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Macro indicators
                      Row(
                        //TODO change blend colors for the macro nutrients
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularPercentIndicator(
                            radius: 15,
                            footer: Text(
                              "Carbs",
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            lineWidth: 3,
                            percent: 1,
                            linearGradient: const LinearGradient(
                              colors: [
                                Colors.yellow,
                                Color.fromARGB(255, 255, 125, 125),
                              ],
                            ),
                            backgroundWidth: 4,
                          ),
                          CircularPercentIndicator(
                            radius: 15,
                            lineWidth: 3,
                            footer: Text(
                              "Protein",
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            percent: 1,
                            linearGradient: const LinearGradient(
                              colors: [
                                Colors.red,
                                Color.fromARGB(255, 255, 125, 125),
                              ],
                            ),
                          ),
                          CircularPercentIndicator(
                            radius: 15,
                            lineWidth: 3,
                            footer: Text(
                              "Fat",
                              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                            ),
                            percent: 1,
                            linearGradient: const LinearGradient(
                              colors: [
                                Colors.green,
                                Color.fromARGB(255, 255, 125, 125),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Date and toggle
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.navigate_before_rounded,
                    ),
                  ),
                  Text(
                    global.currentDate,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.navigate_next_rounded,
                    ),
                  ),
                ],
              ),
            ),
            //Actual food eaten
            SizedBox(
              height: MediaQuery.of(context).size.height * .6,
              width: MediaQuery.of(context).size.width * .9,
              child: ListView.builder(
                  itemCount: meals.keys.length,
                  itemBuilder: (context, index) {
                    String mealName = meals.keys.toList()[index];
                    int mealCalories = 0;
                    List<int> sugg =
                        findSuggestedCalories(mealName, global.calories[global.currentDate]![1] as int);

                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        tileColor: (Theme.of(context).brightness == Brightness.light)
                            ? const Color.fromARGB(255, 246, 174, 45)
                            : const Color.fromARGB(255, 51, 101, 138),
                        title: Text(
                          mealName,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: (meals[mealName]!.isNotEmpty)
                            ? Column(
                                children: (meals[mealName]!).map((dynamic food) {
                                  mealCalories += food[1] as int;
                                  //food is [food name, calories, carbs, fats, protien]
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(food[0]),
                                      Text(food[1].toString()),
                                    ],
                                  );
                                }).toList(),
                              )
                            : Text("Suggested: ${sugg[0]} - ${sugg[1]} "),
                        trailing: Text(
                          "${mealCalories.toString()}\ncal",
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              child: LogPage(
                                global,
                                meal: mealName,
                              ),
                              type: PageTransitionType.bottomToTop,
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageTransition(
              child: LogPage(global),
              type: PageTransitionType.bottomToTop,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

List<int> findSuggestedCalories(String mealName, int totalCalories) {
  //https://www.omnicalculator.com/health/meal-calorie as a source
  double lower = 0;
  double higher = 0;
  if (mealName == "Breakfast") {
    lower = .25;
    higher = .3;
  } else if (mealName == "Snacks") {
    lower = .05;
    higher = .1;
  } else if (mealName == "Lunch") {
    lower = .35;
    higher = .4;
  } else if (mealName == "Dinner") {
    lower = .25;
    higher = .3;
  }

  return [(totalCalories * lower).toInt(), (totalCalories * higher).toInt()];
}
