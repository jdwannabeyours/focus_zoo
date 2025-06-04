import 'package:hive/hive.dart';

part 'animal.g.dart';

@HiveType(typeId: 2)
class Animal {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String type; // 'pig'
  @HiveField(2)
  final String variant; // e.g. 'basic'
  @HiveField(3)
  String mood; // 'happy' or 'sad'
  @HiveField(4)
  bool unlocked;

  Animal({
    required this.id,
    required this.type,
    required this.variant,
    required this.mood,
    required this.unlocked,
  });
}