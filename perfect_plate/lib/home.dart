import 'package:flutter/material.dart';
import 'bottom_buttons.dart';
import 'global.dart';
import 'package:http/http.dart' as http;

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
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        label: Text("Name of food"),
                        hintText: "ex. carrots",
                      ),
                      onSubmitted: (name) async {
                        //TODO fugure out best way for URL
                        String url =
                            "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=${global.usdaKey}&query=${name}&%5BBranded%5D";
                        //So this basically return 50
                        print(url);
                        http.Response response = await http.get(Uri.parse(url));
                        print(response);
                      },
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
