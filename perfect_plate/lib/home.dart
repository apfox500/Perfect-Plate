import 'package:flutter/material.dart';
import 'bottom_buttons.dart';
import 'global.dart';

class HomePage extends StatefulWidget {
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
