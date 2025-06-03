class Plan {
  final String id;
  final String name;
  final Duration duration;
  final DateTime startTime;
  final bool isIntensive;
  final bool limitMode; // Reverse Forest
  final bool completed;
  final bool broken; // If the user failed

  Plan({
    required this.id,
    required this.name,
    required this.duration,
    required this.startTime,
    this.isIntensive = false,
    this.limitMode = false,
    this.completed = false,
    this.broken = false,
  });
}