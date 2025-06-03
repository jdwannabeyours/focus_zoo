import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(FocusZooApp());
}

class FocusZooApp extends StatelessWidget {
  const FocusZooApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Focus Zoo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}