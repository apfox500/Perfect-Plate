import 'main.dart';

class Global {
  //Where global variables are housed
  //Flutter best practice is to not have actual global variables bc then hacking is easier
  //so we will follow this here
  //int calories;
  //TODO: make calories look like below
  late String currentDate;
  Map<String, List<dynamic>> calories =
      {}; //Date :[calories eaten, calorie goal {"name of food":  [calories, grams of protein, grams of carbs, grams of fat]...]
  //Some helpful things for dealing with nulls and null checks(happens with maps a lot)
  //When you call mapName[some key], it may return null, so you attach a "!" to the end of it, telling the computer you know it exists
  //If you don't know or it could be null, then do mapName[some key]?? other value to plug in
  //remember, command + . is your best friend(half of the time you see squiggles)
  Global() {
    //I will handle the syncing with the user
    //for now just throw some starter values into here until I get the database up and running

    //calories = {DateTime.now():[[200, 2200],["food1", 200, 12, 5, 6]]}
    currentDate = DateTime.now().toFormattedString();
  }
}
