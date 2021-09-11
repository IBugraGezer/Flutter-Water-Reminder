import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setGoal(int goal) async {
    _prefs!.setInt("goal", goal);
  }

  static int? getGoal() {
    return _prefs?.getInt("goal") ?? 3;
  }

  static setLastDrinkWaterDate(int dateAsMilliSeconds) {
    _prefs!.setInt("lastDrinkWaterDate", dateAsMilliSeconds);
  }

  static Future<int?> getLastDrinkWaterDate() async {
    // ignore: await_only_futures
    return await _prefs!.getInt("lastDrinkWaterDate") ?? 0;
  }

  static increaseTodayDrinks() async {
    int? currentTodayDrink = getTodayDrinks();
    print(currentTodayDrink);
    _prefs!.setInt("todayDrinks", currentTodayDrink! + 1);
  }

  static resetTodayDrinks() async {
    _prefs!.setInt("todayDrinks", 0);
  }

  static int? getTodayDrinks() {
    return _prefs?.getInt("todayDrinks") ?? 0;
  }

  static bool isGoalReached() {
    int? todayDrinks = getTodayDrinks();
    int? goal = getGoal();
    if (todayDrinks != null && goal != null)
      return todayDrinks >= goal;
    else
      return false;
  }
}
