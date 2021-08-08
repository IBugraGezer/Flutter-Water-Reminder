import 'package:shared_preferences/shared_preferences.dart';

class DailyGoalSimplePreferences {
  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static setGoal(int goal) async {
    _prefs!.setInt("goal", goal);
  }

  static Future<int?> getGoal() async {
    // ignore: await_only_futures
    return await _prefs!.getInt("goal");
  }
}
