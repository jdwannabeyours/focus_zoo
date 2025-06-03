import 'package:flutter/material.dart';
import '../models/focus_type.dart';
import 'focus_status_screen.dart';


class TimerSelectionScreen extends StatefulWidget {
  const TimerSelectionScreen({super.key});

  @override
  State<TimerSelectionScreen> createState() => _TimerSelectionScreenState();
}

class _TimerSelectionScreenState extends State<TimerSelectionScreen> {
  int _minutes = 25;
  String _topic = '';
  FocusType _focusType = FocusType.productive;

  void _startCountdown() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => FocusStatusScreen(
          topic: _topic,
          minutes: _minutes,
          focusType: _focusType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Focus Time")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Focus type selection
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Type: "),
                DropdownButton<FocusType>(
                  value: _focusType,
                  items: [
                    DropdownMenuItem(
                      value: FocusType.productive,
                      child: Text("Productive"),
                    ),
                    DropdownMenuItem(
                      value: FocusType.relax,
                      child: Text("Relax"),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _focusType = value);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: "Focus Topic",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => _topic = value),
            ),
            SizedBox(height: 32),
            Text("Select Minutes", style: TextStyle(fontSize: 18)),
            Slider(
              value: _minutes.toDouble(),
              min: 5,
              max: 120,
              divisions: 23,
              label: '$_minutes min',
              onChanged: (value) => setState(() => _minutes = value.round()),
            ),
            Text("$_minutes minutes", style: TextStyle(fontSize: 24)),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _topic.trim().isEmpty ? null : _startCountdown,
              child: Text("Start Focus"),
            ),
          ],
        ),
      ),
    );
  }
}