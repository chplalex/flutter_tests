import 'package:flutter/material.dart';

class Test09 extends StatefulWidget {
  const Test09({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test09> with SingleTickerProviderStateMixin {
  static const _min = 0.0;
  static const _max = 9.0;

  var _range = const RangeValues(_min, _max);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test 09: Range Slider Tickers", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(child: _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return SliderTheme(
      data: const SliderThemeData(
        rangeTickMarkShape: RectTickMarkShape(width: 1, height: 40),
        // rangeTickMarkShape: RoundRangeSliderTickMarkShape(tickMarkRadius: 2.0),
        trackShape: RectangularSliderTrackShape(),
        trackHeight: 21,
        minThumbSeparation: 0.0,
      ),
      child: RangeSlider(
        min: _min,
        max: _max,
        values: _range,
        divisions: 3,
        onChanged: (values) {
          debugPrint("values: $values");
          setState(() => _range = values);
        },
      ),
    );
  }
}

class RectTickMarkShape extends RangeSliderTickMarkShape {
  final double width;
  final double height;

  const RectTickMarkShape({required this.width, required this.height});

  @override
  Size getPreferredSize({required SliderThemeData sliderTheme, bool? isEnabled}) {
    return Size(width, height);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset startThumbCenter,
    required Offset endThumbCenter,
    bool? isEnabled,
    required TextDirection textDirection,
  }) {
    final paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.fill;

    debugPrint("center: $center, startThumbCenter: $startThumbCenter, endThumbCenter: $endThumbCenter");

    final left = startThumbCenter.dx - width / 2;
    final top = startThumbCenter.dy - height / 2;
    context.canvas.drawRect(Rect.fromLTWH(left, top, width, height), paint);

    // context.canvas.drawCircle(center, 1.0, paint);
  }
}
