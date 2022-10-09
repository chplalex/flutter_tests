// the new widget for the wave visualizing

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tests/wave_widget.dart';

class Test03 extends StatefulWidget {
  const Test03({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test03> {
  final _stateStreamController = StreamController<WaveWidgetState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(0, kToolbarHeight),
          child: WaveWidget(stateStream: _stateStreamController.stream, backgroundColor: Colors.blueGrey),
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
}
