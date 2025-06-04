import 'focus_type.dart';
import 'package:hive/hive.dart';

part 'plan_history.g.dart';

@HiveType(typeId: 0)
class PlanHistory {
  @HiveField(0)
  final String topic;
  @HiveField(1)
  final int minutes;
  @HiveField(2)
  final FocusType focusType;
  @HiveField(3)
  final bool success;
  @HiveField(4)
  final DateTime dateTime;
  @HiveField(5)
  final int? actualMinutes;
  @HiveField(6)
  final int? actualSeconds;

  PlanHistory({
    required this.topic,
    required this.minutes,
    required this.focusType,
    required this.success,
    required this.dateTime,
    this.actualMinutes,
    this.actualSeconds,
  });
}