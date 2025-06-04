import 'package:hive/hive.dart';
import 'animal.dart';

class ZooData {
  static Future<Box<Animal>> _getBox() async {
    return await Hive.openBox<Animal>('zooBox');
  }

  static Future<List<Animal>> getAnimals() async {
    final box = await _getBox();
    return box.values.toList();
  }

  static Future<void> updateZooOnRelaxSuccess() async {
    final box = await _getBox();
    final sadPigKey = box.keys.firstWhere(
      (key) {
        final animal = box.get(key);
        return animal?.type == 'pig' && animal?.mood == 'sad';
      },
      orElse: () => null,
    );
    if (sadPigKey != null) {
      final pig = box.get(sadPigKey)!;
      pig.mood = 'happy';
      await box.put(sadPigKey, pig);
    } else {
      final newPig = Animal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        type: 'pig',
        variant: 'basic',
        mood: 'happy',
        unlocked: true,
      );
      await box.add(newPig);
    }
  }

  static Future<void> updateZooOnProductiveFail() async {
    final box = await _getBox();
    final happyPigKey = box.keys.firstWhere(
      (key) {
        final animal = box.get(key);
        return animal?.type == 'pig' && animal?.mood == 'happy';
      },
      orElse: () => null,
    );
    if (happyPigKey != null) {
      final pig = box.get(happyPigKey)!;
      pig.mood = 'sad';
      await box.put(happyPigKey, pig);
    }
  }
}