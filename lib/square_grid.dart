import 'dart:math';

import 'package:flutter/material.dart';

class SquareGrid extends StatelessWidget {
  final int gridDimension;
  final double gridSize;

  const SquareGrid({
    super.key,
    required this.gridDimension,
    required this.gridSize,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(gridSize),
      painter: _GridPainter(dimension: gridDimension),
    );
  }
}

class _GridPainter extends CustomPainter {
  final int dimension;

  _GridPainter({required this.dimension});

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final gridSize = min(size.width, size.height);
    final cellSize = gridSize / dimension;

    for (var i = 0; i <= dimension; i++) {
      final y = i * cellSize;
      canvas.drawLine(Offset(0, y), Offset(gridSize, y), paint);
    }

    for (var i = 0; i <= dimension; i++) {
      final x = i * cellSize;
      canvas.drawLine(Offset(x, 0), Offset(x, gridSize), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) {
    return oldDelegate.dimension != dimension || oldDelegate.dimension != dimension;
  }
}
