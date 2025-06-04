import 'package:hive/hive.dart';

part 'focus_type.g.dart';

@HiveType(typeId: 1)
enum FocusType {
  @HiveField(0)
  productive,
  @HiveField(1)
  relax,
}
