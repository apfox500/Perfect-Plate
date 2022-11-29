import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:perfect_plate/log_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FooterButtons(global, page: "Home"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    /* boxShadow: [
                      BoxShadow(
                        spreadRadius: 5,
                        blurRadius: 5,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ], */
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${global.calories[global.currentDate]![1] - global.calories[global.currentDate]![0]}\ncalories\nremaining",
                              textAlign: TextAlign.center,
                            ),
                            CircularPercentIndicator(
                              radius: 50,
                              percent: global.calories[global.currentDate]![0] /
                                  global.calories[global.currentDate]![1],
                              center: Text("${global.calories[global.currentDate]![0]}"),
                              footer: const Text("Calories Eaten"),
                            ),
                            const Text(
                              "__\ncalories\nburned",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularPercentIndicator(
                              radius: 15,
                              footer: const Text("Carbs"),
                              lineWidth: 3,
                            ),
                            CircularPercentIndicator(
                              radius: 15,
                              lineWidth: 3,
                              footer: const Text("Protein"),
                            ),
                            CircularPercentIndicator(
                              radius: 15,
                              lineWidth: 3,
                              footer: const Text("Fat"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
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
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.navigate_next_rounded,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .6,
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
