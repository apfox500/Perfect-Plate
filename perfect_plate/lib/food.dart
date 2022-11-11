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
    List<String> ingredients = (json["ingredients"] as String).split(", ");
    //TODO: finish JSON decoding
    Food ret = Food(
      name: json["lowercaseDescription"],
    );

    return ret;
  }
}
