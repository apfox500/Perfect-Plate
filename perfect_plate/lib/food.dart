//For help formatting the http request from usda api:
//https://fdc.nal.usda.gov/api-spec/fdc_api.html#/
class Food {
  final String name;
  String? brandName;
  List<List<dynamic>> servingSize; //[[amount, unit]]
  Map<String, double> nutritionInfo; //{nutition:info} ex: calories:200
  List<String> ingredients;
  String foodCategory;

  //Constructor for the food class
  Food({
    required this.name,
    this.brandName,
    required this.servingSize,
    required this.nutritionInfo,
    required this.ingredients,
    required this.foodCategory,
  });

  //JSON constructor
  factory Food.fromJson(Map<String, dynamic> json) {
    List<List<dynamic>> servingSize = [
      [json["servingSize"], json["servingSizeUnit"]]
    ];
    try {
      servingSize.add(json["householdServingFullText"].split(" "));
    } catch (_) {
      print(_);
    }

    Map<String, double> nutritionInfo = {};
    List<dynamic> foodNutrients = json["foodNutrients"] as List<dynamic>;
    for (dynamic nutrient in foodNutrients) {
      Map<dynamic, dynamic> nutrientMap = nutrient as Map<dynamic, dynamic>;
      String name = (nutrientMap["nutrientName"] as String);
      if (!name.contains("Fatty")) {
        name = name.split(", ")[0];
      }
      double nutrientNumber = double.parse(nutrientMap["nutrientNumber"] as String);
      nutritionInfo[name] = nutrientNumber;
    }

    List<String> ingredients = (json["ingredients"] as String).split(", ");
    Food ret = Food(
        name: json["lowercaseDescription"],
        servingSize: servingSize,
        nutritionInfo: nutritionInfo,
        ingredients: ingredients,
        foodCategory: json["foodCategory"],
        brandName: json["brandOwner"]);

    return ret;
  }

  String simple4() {
    String ret =
        "Calories: ${nutritionInfo["Energy"].toString()}\n Protein: ${nutritionInfo["Protein"].toString()}\n Carbs: ${nutritionInfo["Carbohydrate"].toString()}\n Fat: ${nutritionInfo["Total lipid (fat)"].toString()}";
    return ret;
  }

  //TODO create a toString
  //multiple versions, total, nutrition overview(simple4 but nice), and serving size based
}
