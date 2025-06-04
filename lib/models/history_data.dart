import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'plan_history.dart';


class HistoryData {
  static Future<String?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('current_user');
  }

  static Future<String> _getKey() async {
    final user = await getCurrentUser();
    return 'plan_history_${user ?? "guest"}';
  }

  static Future<List<PlanHistory>> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    final List decoded = json.decode(jsonString);
    return decoded.map((e) => PlanHistory.fromJson(e)).toList();
  }

  static Future<void> saveHistory(List<PlanHistory> history) async {
    final prefs = await SharedPreferences.getInstance();
    final key = await _getKey();
    final jsonString = json.encode(history.map((e) => e.toJson()).toList());
    await prefs.setString(key, jsonString);
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