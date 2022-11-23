import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bottom_buttons.dart';
import 'food.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
  final Global global;
  const HomePage(this.global, {Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<dynamic>> foods = [
    ["carrots", 70],
    ["peas", 60],
    ["fries", 50]
  ];
  List<Food> foodOptions = [];
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
            children: [
              //Colorie display
              Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${global.calories}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              //list of things we've eaten
              SizedBox(
                height: MediaQuery.of(context).size.height * .7,
                width: MediaQuery.of(context).size.width - 16,
                child: ListView.builder(
                  itemCount: foods.length,
                  itemBuilder: ((context, i) {
                    global.calories += (foods[i][1]) as int;
                    return Card(
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
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nameController = TextEditingController();

          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: (foodOptions.isEmpty)
                        ? [
                            TextField(
                              controller: nameController,
                              decoration: const InputDecoration(
                                label: Text("Name of food"),
                                hintText: "ex. carrots",
                              ),
                              onSubmitted: (name) async {
                                //TODO figure out best way for URL
                                String url =
                                    "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=${global.usdaKey}&query=${name}&dataType=Branded&dataType=Foundation&sortBy=publishedDate&sortOrder=desc";
                                //So this basically returns most recent 50
                                //it took like 2 hours to get the url to work, please don't break

                                http.Response response = await http.get(Uri.parse(url));
                                //just gets the foods from theat json mess
                                Iterable l = json.decode(response.body)["foods"];
                                //maps them into a list of foods
                                foodOptions = List<Food>.from(l.map((model) => Food.fromJson(model)));
                                //now to clean up duplicates
                                for (int i = 0; i < foodOptions.length; i++) {
                                  try {
                                    String company = foodOptions[i].brandName!;
                                    String name = foodOptions[i].name;
                                    for (int j = i + 1; j < foodOptions.length; j++) {
                                      if (foodOptions[j].name == name && foodOptions[j].brandName! == company) {
                                        foodOptions.removeAt(j);
                                      }
                                    }
                                  } catch (_) {
                                    print(_);
                                  }
                                }
                                //Then to display it
                                setState(() {});
                              },
                            ),
                          ]
                        : [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .5,
                              width: MediaQuery.of(context).size.width * .95,
                              child: ListView.builder(
                                  itemCount: foodOptions.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      child: Column(
                                        children: [
                                          Text(
                                            foodOptions[index].name,
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          Text(
                                            foodOptions[index].simple4(),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
