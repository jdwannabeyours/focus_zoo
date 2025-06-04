import 'package:shared_preferences/shared_preferences.dart';
import 'plan_history.dart';
import 'package:hive/hive.dart';


class HistoryData {
  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_user');
  }

  static Future<String> _getBoxName() async {
    final user = await getCurrentUser();
    return 'plan_history_${user ?? "guest"}';
  }

  static Future<List<PlanHistory>> loadHistory() async {
    final boxName = await _getBoxName();
    final box = await Hive.openBox<PlanHistory>(boxName);
    return box.values.toList();
  }

  static Future<void> addHistory(PlanHistory plan) async {
    final boxName = await _getBoxName();
    final box = await Hive.openBox<PlanHistory>(boxName);
    await box.add(plan);
  }

  static Future<void> saveHistory(List<PlanHistory> history) async {
    final boxName = await _getBoxName();
    final box = await Hive.openBox<PlanHistory>(boxName);
    await box.clear();
    await box.addAll(history);
  }
}

String formatDuration(int seconds) {
  final m = seconds ~/ 60;
  final s = seconds % 60;
  if (m > 0 && s > 0) {
    return '$m minute${m == 1 ? '' : 's'} $s second${s == 1 ? '' : 's'}';
  } else if (m > 0) {
    return '$m minute${m == 1 ? '' : 's'}';
  } else {
    return '$s second${s == 1 ? '' : 's'}';
  }
}