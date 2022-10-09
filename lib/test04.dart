// the new widget for the wave visualizing

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tests/wave_widget.dart';
import 'package:music_visualizer/music_visualizer.dart';

class Test04 extends StatefulWidget {
  const Test04({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test04> {
  final _stateStreamController = StreamController<WaveWidgetState>();
  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, kToolbarHeight),
          child: _musicVisualizer(),
        ),
        backgroundColor: Colors.blueGrey,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _button("Init", onPressedInit),
              _button("Play", onPressedPlay),
              _button("Stop", onPressedStop),
            ],
          ),
        ),
      ),
    );
  }

  MaterialButton _button(String title, void Function() onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 75,
        width: 150,
        color: Colors.blue,
        child: Text(title),
      ),
    );
  }

  void onPressedInit() {
    _stateStreamController.add(WaveWidgetState.init);
  }

  void onPressedPlay() {
    _stateStreamController.add(WaveWidgetState.play);
  }

  void onPressedStop() {
    _stateStreamController.add(WaveWidgetState.stop);
  }

  @override
  void dispose() {
    _stateStreamController.close();
    super.dispose();
  }

  Widget _musicVisualizer() {
    const colorRedRussia = Color(0xffd52b1e);
    const colorBlueRussia = Color(0xff0039a6);
    const colorGreenBelarus = Color(0xff007c30);
    const List<Color> colors = [
      colorRedRussia,
      colorGreenBelarus,
      Colors.white,
      colorBlueRussia,
    ];

    final List<int> duration = [
      _randomDuration(),
      _randomDuration(),
      _randomDuration(),
      _randomDuration(),
      _randomDuration(),
    ];

    return SizedBox(
      height: kToolbarHeight,
      child: MusicVisualizer(
        barCount: 30,
        colors: colors,
        duration: duration,
      ),
    );
  }

  int _randomDuration() => 350 + _random.nextInt(400);
}
