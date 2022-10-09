import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';

enum FlagsWidgetMode { stop, init, play }

class FlagsWidget extends StatefulWidget {
  final double width;
  final double height;
  final Stream<FlagsWidgetMode> modeStream;
  final Color backgroundColor;

  const FlagsWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.modeStream,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FlagsWidgetState();
}

class _FlagsWidgetState extends State<FlagsWidget> {
  static const _flagRU = "assets/images/Flag_of_Russia.png";
  static const _flagBY = "assets/images/Flag_of_Belarus.png";
  static const _animationDuration = Duration(milliseconds: 1000);

  final _random = Random();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: widget.backgroundColor),
        StreamBuilder<FlagsWidgetMode>(
            stream: widget.modeStream,
            builder: (buildContext, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                switch (snapshot.data!) {
                  case FlagsWidgetMode.init:
                    return _initVisualizer();
                  case FlagsWidgetMode.stop:
                    return _stopVisualizer();
                  case FlagsWidgetMode.play:
                    return _playVisualizer();
                }
              } else {
                return Container();
              }
            }),
      ],
    );
  }

  Widget _initVisualizer() => LoopAnimationBuilder<double>(
      duration: _animationDuration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (_, ratio, __) => _clipHoleBuilder(ratio));

  Widget _clipHoleBuilder(double ratio) => ClipPath(
        clipper: HoleWidget(ratio: ratio),
        child: _backgroundWidget(),
      );

  Widget _stopVisualizer() => MirrorAnimationBuilder<double>(
      duration: _animationDuration,
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (_, ratio, __) => _clipHoleBuilder(ratio));

  Widget _backgroundWidget() => Row(
        children: [
          SizedBox(
            width: widget.width / 2,
            height: widget.height,
            child: FittedBox(fit: BoxFit.fill, child: Image.asset(_flagBY)),
          ),
          SizedBox(
            width: widget.width / 2,
            height: widget.height,
            child: FittedBox(fit: BoxFit.fill, child: Image.asset(_flagRU)),
          )
        ],
      );

  Widget _playVisualizer() {
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
      width: widget.width,
      height: widget.height,
      child: PlayVisualizer(
        barCount: 30,
        colors: colors,
        duration: duration,
      ),
    );
  }

  int _randomDuration() => 350 + _random.nextInt(400);
}

class HoleWidget extends CustomClipper<Path> {
  final double ratio;

  HoleWidget({required this.ratio});

  @override
  Path getClip(Size size) {
    final dX = (size.width + size.height) * ratio - size.height;
    final offset = Offset(dX, 0);

    final path = Path()..fillType = PathFillType.evenOdd;
    final oval = Rect.fromLTRB(0, 0, size.height, size.height).shift(offset);
    path.addOval(oval);

    return path;
  }

  @override
  bool shouldReclip(covariant HoleWidget oldClipper) {
    return ratio != oldClipper.ratio;
  }
}

class PlayVisualizer extends StatelessWidget {
  final List<Color> colors;
  final List<int> duration;
  final int barCount;

  const PlayVisualizer({
    Key? key,
    required this.colors,
    required this.duration,
    required this.barCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
        barCount,
        (index) => PlayVisualComponent(
          duration: duration[index % duration.length],
          color: colors[index % colors.length],
        ),
      ),
    );
  }
}

class PlayVisualComponent extends StatelessWidget {
  final int duration;
  final Color color;

  const PlayVisualComponent({Key? key, required this.duration, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) => LoopAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: 50),
        duration: Duration(milliseconds: duration),
        curve: Curves.easeInQuad,
        builder: (_, value, __) => Container(
          width: 3,
          height: value,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        ),
      );
}
