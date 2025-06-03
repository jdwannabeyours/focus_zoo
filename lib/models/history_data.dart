import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'plan_history.dart';

class HistoryData {
  static const _key = 'plan_history';

  static Future<List<PlanHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List decoded = json.decode(jsonString);
    return decoded.map((e) => PlanHistory.fromJson(e)).toList();
  }

  static Future<void> saveHistory(List<PlanHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(history.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }

  static Future<void> addHistory(PlanHistory plan) async {
    final history = await loadHistory();
    history.add(plan);
    await saveHistory(history);
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