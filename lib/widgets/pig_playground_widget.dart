import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/animal.dart';
import 'animated_pig_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PigPlaygroundWidget extends StatefulWidget {
  const PigPlaygroundWidget({super.key});

  @override
  State<PigPlaygroundWidget> createState() => _PigPlaygroundWidgetState();
}

class _PigPlaygroundWidgetState extends State<PigPlaygroundWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _positions;
  late List<Offset> _targets;
  final double pigSize = 40;
  final Random _random = Random();

  List<Animal> _animals = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..addListener(_movePigs)
     ..repeat();

    _loadAnimals();
  }

  void _loadAnimals() {
    final box = Hive.box<Animal>('zooBox');
    setState(() {
      _animals = box.values.where((a) => a.type == 'pig').toList();
      _positions = List.generate(_animals.length, (_) => _randomOffset());
      _targets = List.generate(_animals.length, (_) => _randomOffset());
    });
    box.listenable().addListener(() {
      setState(() {
        _animals = box.values.where((a) => a.type == 'pig').toList();
        // Reset positions and targets if animal count changes
        _positions = List.generate(_animals.length, (_) => _randomOffset());
        _targets = List.generate(_animals.length, (_) => _randomOffset());
      });
    });
  }

  Offset _randomOffset() {
    // Playground size: 300x200, pig size: 40
    return Offset(
      20 + _random.nextDouble() * (300 - pigSize - 40),
      20 + _random.nextDouble() * (200 - pigSize - 40),
    );
  }

  void _movePigs() {
    setState(() {
      for (int i = 0; i < _positions.length; i++) {
        final current = _positions[i];
        final target = _targets[i];
        final dx = target.dx - current.dx;
        final dy = target.dy - current.dy;
        if (dx.abs() < 2 && dy.abs() < 2) {
          // Arrived, pick new target
          _targets[i] = _randomOffset();
        } else {
          // Move a bit closer to target
          _positions[i] = Offset(
            current.dx + dx * 0.003,
            current.dy + dy * 0.003,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 200,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              color: Colors.green[100],
            ),
          ),
          // Pigs
          for (int i = 0; i < _animals.length; i++)
            Positioned(
              left: _positions[i].dx,
              top: _positions[i].dy,
              child: AnimatedPigWidget(mood: _animals[i].mood),
            ),
        ],
      ),
    );
  }
}