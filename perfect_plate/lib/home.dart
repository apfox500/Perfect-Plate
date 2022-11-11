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
  List<List<dynamic>> foods = [
    ["carrots", 70],
    ["peas", 60],
    ["fries", 50]
  ];

  List<Widget> foodsForDay(DateTime date) {
    //I moved this up here so you can put things on the bottom
    //TODO: Separate into chunks by Meal(brekfast, lunch, dinner, snacks)
    List<Widget> widgets = [];
    for (int i = 0; i < foods.length; i++) {
      widgets.add(
        Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                foods[i][0].toString(),
              ),
              Text(
                foods[i][1].toString(),
              ),
            ],
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Global global = widget.global;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: FooterButtons(global, page: "Home"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                  //TODO: put the date somewhere on the screen(top, bottom, whereever you think is best)
                  //TODO: throw this container into a row, with IconButton()s on either side(use MainAxis spaceBetween) to toggle between dates
                  //Calorie display
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${global.calories}",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),
                ] +
                foodsForDay(DateTime.now()) + //list of things we've eaten
                [
                  //TODO: put the calories remaning here(or wherever else you think will work)
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
                    TextField(
                      controller: nameController,
                      decoration:
                          const InputDecoration(label: Text("Name of food"), hintText: "ex. carrots"),
                      onSubmitted: (val) {
                        foods.add([val, int.parse(calController.text)]);
                        Navigator.pop(context);

                        setState(() {});
                      },
                    ),
                    TextField(
                      controller: calController,
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
