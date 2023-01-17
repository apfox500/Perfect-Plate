import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../utilities/food.dart';
import '../models/global.dart';

Future<List<Food>> searchFood({String? name, String? upc}) async {
  if (name == null && upc == null) {
    throw Exception("name and upc cannot both be null");
  } else if (name != null) {
    //search by name
    String url =
        "https://api.edamam.com/api/food-database/v2/parser?app_id=${Global.edamamID}&app_key=${Global.edamamKey}&ingr=$name&nutrition-type=cooking";
    Response response = await http.get(Uri.parse(url));
    dynamic jsonFood = convert.jsonDecode(response.body);
    List<dynamic> hints = jsonFood["hints"] as List<dynamic>;
    List<Food> ret = [];
    for (var element in hints) {
      Food food = IncompleteFood.fromJson(element);
      ret.add(food);
    }
    return ret;
  } else {
    //search by upc
  }

  throw UnimplementedError();
}
