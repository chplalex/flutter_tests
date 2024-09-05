import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tests/animated_circle.dart';
import 'package:flutter_tests/square_grid.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mapSize = min(size.height, size.width);
    return Scaffold(
      appBar: AppBar(
        title: Text("Test - Open mail app", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Stack(
        children: [
          SquareGrid(gridDimension: 10, gridSize: mapSize),
          const Positioned(
            top: 0.0,
            left: 0.0,
            child: AnimatedCircle(diameter: 100.0),
          ),
        ],
      ),
    );
  }
}
