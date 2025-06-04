import 'package:flutter/material.dart';
import '../widgets/pig_playground_widget.dart';
import 'timer_selection_screen.dart'; 
import 'history_page_screen.dart'; 
import '../models/history_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import '../widgets/animated_pig_widget.dart';
import 'package:hive/hive.dart';
import '../models/animal.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _username;
  String _getOverallMood(List<Animal> animals) {
  if (animals.any((a) => a.type == 'pig' && a.mood == 'happy')) {
    return 'happy';
  }
  // If there are pigs but none are happy, show sad
  if (animals.any((a) => a.type == 'pig')) {
    return 'sad';
  }
  // If there are no pigs, default to happy or sad as you wish
  return 'happy';
  }
  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('current_user');
    });
  }

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
        title: Text(_username != null ? "Focus Zoo - $_username" : "Focus Zoo"),
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
    const SizedBox(height: 8),
    ValueListenableBuilder(
      valueListenable: Hive.box<Animal>('zooBox').listenable(),
      builder: (context, Box<Animal> box, _) {
        final animals = box.values.toList();
        final mood = _getOverallMood(animals);
        return AnimatedPigWidget(mood: mood);
      },
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: LinearProgressIndicator(value: 0.4),
    ),
    // Make the playground take available space, but not all
    SizedBox(
      height: 200, // or Flexible(child: ...)
      child: PigPlaygroundWidget(),
    ),
    const SizedBox(height: 16),
    // Plan Actions
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _startFocus(context),
          child: const Text("Start Plan"),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement Intensive Plan logic
          },
          child: const Text("Intensive Plan"),
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
          child: const Text("History"),
        ),
      ],
    ),
    const SizedBox(height: 16),
  ],
)
    );
  }
}