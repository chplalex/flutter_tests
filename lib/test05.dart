// the widget for the wave visualizing
// there are three mode - init, play and stop
// the widget is operated by the mode stream

import 'dart:async';

import 'package:flutter/material.dart';

import 'flags_widget.dart';

class Test05 extends StatelessWidget {
  final _modeStreamController = StreamController<FlagsWidgetMode>();

  Test05({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final kToolbarWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(kToolbarWidth, kToolbarHeight),
          child: FlagsWidget(
            width: kToolbarWidth,
            height: kToolbarHeight,
            modeStream: _modeStreamController.stream,
            backgroundColor: Colors.blueGrey,
          ),
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
    _modeStreamController.add(FlagsWidgetMode.init);
  }

  void onPressedPlay() {
    _modeStreamController.add(FlagsWidgetMode.play);
  }

  void onPressedStop() {
    _modeStreamController.add(FlagsWidgetMode.stop);
  }
}
