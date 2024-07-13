import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_proxy/http_proxy.dart';

class Test10 extends StatefulWidget {
  final HttpProxy? httpProxy;

  const Test10({Key? key, required this.httpProxy}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test10> with SingleTickerProviderStateMixin {
  static const url = 'https://api.github.com/users/wslaimin';

  late final Future<Response> _future;

  @override
  void initState() {
    super.initState();
    _future = get(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test 10: Http Proxy test",
            style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(child: _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'proxyHost: ${widget.httpProxy?.host}',
          style: const TextStyle(fontSize: 20),
        ),
        Text(
          'proxyPort: ${widget.httpProxy?.port}',
          style: const TextStyle(fontSize: 20),
        ),
        const Text(
          'url:$url',
          style: TextStyle(fontSize: 16),
        ),
        const Divider(height: 30),
        Expanded(
          child: Center(
            child: FutureBuilder<Response>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(snapshot.data?.body.toString() ?? 'null'),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class RectTickMarkShape extends RangeSliderTickMarkShape {
  final double width;
  final double height;

  const RectTickMarkShape({required this.width, required this.height});

  @override
  Size getPreferredSize(
      {required SliderThemeData sliderTheme, bool? isEnabled}) {
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

    debugPrint(
        "center: $center, startThumbCenter: $startThumbCenter, endThumbCenter: $endThumbCenter");

    final left = startThumbCenter.dx - width / 2;
    final top = startThumbCenter.dy - height / 2;
    context.canvas.drawRect(Rect.fromLTWH(left, top, width, height), paint);

    // context.canvas.drawCircle(center, 1.0, paint);
  }
}
