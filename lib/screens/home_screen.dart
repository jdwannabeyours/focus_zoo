import 'package:flutter/material.dart';
import '../widgets/zoo_grid_widget.dart';
import 'timer_selection_screen.dart'; 
import 'history_page_screen.dart'; 
import '../models/history_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _startFocus(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TimerSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text("Focus Zoo"),
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('current_user');
            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false,
          );
        }
      },
    ),
  ],
),
      body: Column(
        children: [
          // XP Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LinearProgressIndicator(value: 0.4), // Example value
          ),
          // Current Animals
          Expanded(
            child: ZooGridWidget(),
          ),
          // Plan Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _startFocus(context), // Use the function
                child: Text("Start Plan"),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement Intensive Plan logic
                },
                child: Text("Intensive Plan"),
              ),
              ElevatedButton(
                onPressed: () async {
                 final historyList = await HistoryData.loadHistory();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                     builder: (context) => HistoryScreen(historyList: historyList),
                     ),
                   );
            },
             child: Text("History"),
),
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}