import 'package:flutter/material.dart';
import '../models/plan_history.dart';
import '../models/focus_type.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  final List<PlanHistory> historyList;

  const HistoryScreen({super.key, required this.historyList});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Focus History')),
      body: historyList.isEmpty
          ? Center(child: Text('No history yet.'))
          : ListView.builder(
              itemCount: historyList.length,
              itemBuilder: (context, index) {
                final plan = historyList[index];
                final formattedTime = DateFormat('h:mm a').format(plan.dateTime);
                return ListTile(
                  leading: Icon(
                    plan.success ? Icons.check_circle : Icons.cancel,
                    color: plan.success ? Colors.green : Colors.red,
                  ),
                  title: Text(plan.topic),
                  subtitle: Text(() {
                    if (plan.focusType == FocusType.relax &&
                        plan.success &&
                        plan.actualSeconds != null) {
                      final early = plan.minutes * 60 - plan.actualSeconds!;
                      return 'Relax • ${plan.minutes} min\nFinished ${formatDuration(early)} early!\n$formattedTime';
                    } else if (plan.focusType == FocusType.productive &&
                        plan.actualSeconds != null) {
                      return 'Productive • ${plan.minutes} min\nYour focus time is ${formatDuration(plan.actualSeconds!)}\n$formattedTime';
                    } else {
                      return '${plan.focusType == FocusType.productive ? "Productive" : "Relax"} • ${plan.minutes} min\n$formattedTime';
                    }
                  }()),
                );
              },
            ),
    );
  }
}