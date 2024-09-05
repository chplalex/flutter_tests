import 'package:flutter/material.dart';

import 'app_constants.dart';

class AnimatedCircle extends StatefulWidget {
  final double diameter;

  const AnimatedCircle({super.key, required this.diameter});

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class _AnimatedCircleState extends State<AnimatedCircle> with SingleTickerProviderStateMixin {
  static const _forwardDuration = Duration(milliseconds: AppConstants.animationForwardInMillis);
  static const _reverseDuration = Duration(milliseconds: AppConstants.animationReverseInMillis);

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _forwardDuration, reverseDuration: _reverseDuration);

    _animation = Tween<double>(begin: 0.0, end: widget.diameter)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.diameter,
      height: widget.diameter,
      child: FittedBox(
        fit: BoxFit.none,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (_, __) {
            return Container(
              width: _animation.value,
              height: _animation.value,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}
