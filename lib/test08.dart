// deep link tests

import 'package:flutter/material.dart';

class Test08 extends StatefulWidget {
  const Test08({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test08> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller
            ..reset()
            ..forward();
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Test 08: Rotate image", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(child: _buildWidget()),
    );
  }

  Widget _buildWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: Image.asset("assets/images/music_01.png", width: 100.0, height: 100.0),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () => _controller.forward(),
          child: const Text("Start"),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () => _controller.stop(),
          child: const Text("Stop"),
        ),
      ],
    );
  }
}
