class Animal {
  final String id;
  final String type; // e.g. 'pig', 'chicken'
  final String variant; // e.g. 'big', 'winged'
  final String mood; // 'happy', 'sad', 'sick', 'excited'
  final int xp; // XP towards next evolution
  final bool unlocked;

  const Animal({
    required this.id,
    required this.type,
    required this.variant,
    required this.mood,
    this.xp = 0,
    this.unlocked = false,
  });
}