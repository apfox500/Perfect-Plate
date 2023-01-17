//For help formatting the http request from usda api:
//https://fdc.nal.usda.gov/api-spec/fdc_api.html#/
abstract class Food {
  final String name;
  final Map<String, double> nutritionInfo; //{nutition:info} ex: calories:200
  final String foodID;
  final String? brand;
  final Map<String, String> measures;

  //Constructor for the food class
  Food({
    required this.name,
    required this.nutritionInfo,
    required this.foodID,
    this.brand,
    required this.measures,
  });

  //TODO create a toString
  //multiple versions, total, nutrition overview(simple4 but nice), and serving size based
}

class CompleteFood extends Food {
  final String ingredients;
  final List<String> healthLabels;

  CompleteFood({
    required super.name,
    required super.nutritionInfo,
    required super.foodID,
    required this.ingredients,
    required this.healthLabels,
    required super.measures,
    super.brand,
  });

  factory CompleteFood.fromJson(Map<String, dynamic> json) {
    //name - label
    //nutrient info
    //foodID
    //
    throw UnimplementedError();
  }
}

class IncompleteFood extends Food {
  IncompleteFood({
    required super.name,
    required super.nutritionInfo,
    required super.foodID,
    required super.measures,
    super.brand,
  });

  factory IncompleteFood.fromJson(Map<String, dynamic> json) {
    Map<dynamic, dynamic> food = json["food"] as Map<dynamic, dynamic>;
    String name = food["label"] as String;
    Map<String, double> nutrientInfo =
        (food["nutrients"] as Map<String, dynamic>).map((key, value) => MapEntry(key, value as double));
    String foodID = food["foodId"] as String;
    String? brand = food["brand"];

    Map<String, String> measures = {};
    for (var element in (json["measures"] as List<dynamic>)) {
      Map<dynamic, dynamic> mapElement = (element as Map<dynamic, dynamic>);
      measures[mapElement["label"] as String] = mapElement["uri"] as String;
    }
    //name - label
    //nutrient info
    //foodID
    //measures
    //brand if it exists

    //return our IncompleteFood
    return IncompleteFood(
      name: name,
      nutritionInfo: nutrientInfo,
      foodID: foodID,
      measures: measures,
      brand: brand,
    );
  }
}
/* //JSON constructor
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
 */