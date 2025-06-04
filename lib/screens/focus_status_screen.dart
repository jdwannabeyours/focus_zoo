import 'package:flutter/material.dart';
import '../models/focus_type.dart';
import 'dart:async';
import '../models/history_data.dart';
import '../models/plan_history.dart';

class FocusStatusScreen extends StatefulWidget {
  final String topic;
  final int minutes;
  final FocusType focusType;

  const FocusStatusScreen({
    super.key,
    required this.topic,
    required this.minutes,
    required this.focusType,
  });

  @override
  State<FocusStatusScreen> createState() => _FocusStatusScreenState();
}

class _FocusStatusScreenState extends State<FocusStatusScreen> {
  late int _secondsLeft;
  Timer? _timer;
  bool _isEnded = false;

  @override
  void initState() {
    super.initState();
    _secondsLeft = widget.minutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() {
          _secondsLeft--;
        });
      } else {
        timer.cancel();
        if (widget.focusType == FocusType.productive) {
          // Productive: timer ends, user succeeded
          _showResultDialog(success: true);
        } else {
          // Relax: timer ends, user failed
          _showResultDialog(success: false);
        }
      }
    });
  }

  void _endSession() {
    _timer?.cancel();
    setState(() {
      _isEnded = true;
    });
    if (widget.focusType == FocusType.productive) {
      // Productive: user ended early, failed
      _showResultDialog(success: false);
    } else {
      // Relax: user ended before timer, succeeded
      _showResultDialog(success: true);
    }
  }

  void _showResultDialog({required bool success}) async {
  int? actualSeconds;
  if (widget.focusType == FocusType.relax) {
    actualSeconds = widget.minutes * 60 - _secondsLeft;
  } else if (widget.focusType == FocusType.productive) {
    actualSeconds = widget.minutes * 60 - _secondsLeft;
  }

  await HistoryData.addHistory(
    PlanHistory(
      topic: widget.topic,
      minutes: widget.minutes,
      focusType: widget.focusType,
      success: success,
      dateTime: DateTime.now(),
      actualSeconds: actualSeconds,
    ),
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      title: Text(success ? "Success!" : "Failed"),
      content: Text(success
          ? (widget.focusType == FocusType.productive
              ? "You focused for the full time!"
              : "You relaxed within the time limit!")
          : (widget.focusType == FocusType.productive
              ? "You ended the session early."
              : "You exceeded the relax time.")),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .popUntil((route) => route.isFirst); // Go back to home
          },
          child: Text("OK"),
        ),
      ],
    ),
  );
}

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.focusType == FocusType.productive ? 'Focusing...' : 'Relaxing...')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.topic,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            Text(
              _formatTime(_secondsLeft),
              style: const TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isEnded ? null : _endSession,
              child: Text(widget.focusType == FocusType.productive ? 'End Session' : 'Finish Relax'),
            ),
          ],
        ),
      ),
    );
  }
}