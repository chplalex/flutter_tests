import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

enum WaveWidgetState { play, stop, init }

class WaveWidget extends StatefulWidget {
  final Stream<WaveWidgetState> stateStream;
  final Color backgroundColor;

  const WaveWidget({Key? key, required this.stateStream, required this.backgroundColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WaveState();
}

class _WaveState extends State<WaveWidget> {
  static const _flagRU = "assets/images/Flag_of_Russia.png";
  static const _flagBY = "assets/images/Flag_of_Belarus.png";
  static const _barsCount = 42;
  static const _ratiosStreamInterval = Duration(milliseconds: 300);

  final _random = math.Random();

  var _background = "";

  @override
  Widget build(BuildContext context) => StreamBuilder<WaveWidgetState>(
        stream: widget.stateStream,
        initialData: WaveWidgetState.init,
        builder: (_, snapshotState) {
          final waveWidgetState = snapshotState.data ?? WaveWidgetState.init;
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: _backgroundImage(),
              ),
            ),
            child: StreamBuilder<List<double>>(
              stream: _ratiosStream(waveWidgetState),
              initialData: const [],
              builder: (_, snapshotRatios) {
                final ratios = snapshotRatios.data ?? [];
                return ClipPath(
                  clipper: WaveBar(ratios: ratios),
                  child: Container(color: widget.backgroundColor),
                );
              },
            ),
          );
        },
      );

  ImageProvider<Object> _backgroundImage() {
    _background = _background == _flagBY ? _flagRU : _flagBY;
    return Image.asset(_background).image;
  }

  Stream<List<double>> _ratiosStream(WaveWidgetState waveWidgetState) {
    switch (waveWidgetState) {
      case WaveWidgetState.init:
        return Stream<List<double>>.periodic(_ratiosStreamInterval, _generateInit);
      case WaveWidgetState.play:
        return Stream<List<double>>.periodic(_ratiosStreamInterval, _generatePlay);
      case WaveWidgetState.stop:
        return Stream<List<double>>.periodic(_ratiosStreamInterval, _generateStop);
    }
  }

  List<double> _generateInit(int computationCount) {
    const stepDegrees = 30;
    const stepFactor = 1 / _barsCount;
    return List<double>.generate(_barsCount, (index) {
      final angle = (index + computationCount) * stepDegrees;
      final factor = index * stepFactor;
      final result = factor * (1 + math.sin(radians((angle).toDouble()))) / 2;
      return result;
    }, growable: false);
  }

  List<double> _generatePlay(int computationCount) {
    return List<double>.generate(_barsCount, (index) => _random.nextDouble(), growable: false);
  }

  List<double> _generateStop(int computationCount) {
    return List<double>.generate(_barsCount, (index) => 1.0, growable: false);
  }
}

class WaveBar extends CustomClipper<Path> {
  final List<double> ratios;

  WaveBar({required this.ratios});

  @override
  Path getClip(Size size) {
    const dividerWidth = 2.0;
    final barWidth = (size.width + dividerWidth) / ratios.length - dividerWidth;
    final pairWidth = barWidth + dividerWidth;

    final path = Path()..fillType = PathFillType.evenOdd;

    ratios.asMap().forEach((index, ratio) {
      final left = index * pairWidth;
      final right = left + barWidth;
      final top = size.height * ratio;
      final bottom = size.height;
      path.addRect(Rect.fromLTRB(left, top, right, bottom));
    });

    path.addRect(Rect.fromLTRB(0, 0, size.width, size.height));

    return path;
  }

  @override
  bool shouldReclip(covariant WaveBar oldClipper) {
    return ratios != oldClipper.ratios;
  }
}
