import 'package:flutter/material.dart';
import '../models/animal.dart';

class ZooGridWidget extends StatelessWidget {
  final List<Animal> animals;

  const ZooGridWidget({super.key, this.animals = const [
  Animal(id: '1', type: 'pig', variant: 'basic', mood: 'happy', unlocked: true),
  // Add demo animals here
]});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: animals.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final animal = animals[index];
        return Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pets, size: 48),
              Text('${animal.type} (${animal.mood})'),
            ],
          ),
        );
      },
    );
  }
}