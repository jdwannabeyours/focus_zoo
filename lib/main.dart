import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const FocusZooApp());
}

class FocusZooApp extends StatelessWidget {
  const FocusZooApp({super.key});

  Future<Widget> _getStartScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('current_user');
    if (user == null) {
      return const LoginScreen();
    } else {
      return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Zoo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: FutureBuilder<Widget>(
        future: _getStartScreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            return snapshot.data!;
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}