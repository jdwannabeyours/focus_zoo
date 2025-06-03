import 'animal.dart';

class Zoo {
  List<Animal> animals;
  int gridRows;
  int gridColumns;

  Zoo({
    required this.animals,
    this.gridRows = 3,
    this.gridColumns = 3,
  });
}