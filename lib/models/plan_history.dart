import 'focus_type.dart';

class PlanHistory {
  final String topic;
  final int minutes;
  final FocusType focusType;
  final bool success;
  final DateTime dateTime;
  final int? actualMinutes; // Add this field
  final int? actualSeconds;

  PlanHistory({
    required this.topic,
    required this.minutes,
    required this.focusType,
    required this.success,
    required this.dateTime,
    this.actualMinutes, // Add to constructor
    this.actualSeconds,
  });

  Map<String, dynamic> toJson() => {
        'topic': topic,
        'minutes': minutes,
        'focusType': focusType.index,
        'success': success,
        'dateTime': dateTime.toIso8601String(),
        'actualMinutes': actualMinutes,
        'actualSeconds': actualSeconds,
      };

  factory PlanHistory.fromJson(Map<String, dynamic> json) => PlanHistory(
        topic: json['topic'],
        minutes: json['minutes'],
        focusType: FocusType.values[json['focusType']],
        success: json['success'],
        dateTime: DateTime.parse(json['dateTime']),
        actualMinutes: json['actualMinutes'],
        actualSeconds: json['actualSeconds'],
      );
}