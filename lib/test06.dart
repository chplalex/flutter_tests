// the custom outline button for the magen project

import 'package:flutter/material.dart';

class Test06 extends StatelessWidget {
  const Test06({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test 06: CustomOutlineButton", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 150, height: 5, color: Colors.red),
              const SizedBox(height: 5),
              CustomOutlineButton(text: "Calibrate sensor", width: 150, function: () => {})
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatelessWidget {
  static const _height = 26.7;
  static const _radius = 20.0;
  static const _stroke = 1.5;

  final String text;
  final Function function;
  final double width;
  final Color? color;
  final TextStyle? textStyle;

  const CustomOutlineButton(
      {Key? key, required this.text, required this.function, required this.width, this.color, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width,
          height: _height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(_radius)),
            gradient: LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(1, 1),
              colors: [Color(0xff009dee), AppColors.soft_torqueze],
            ),
          ),
        ),
        Container(
          width: width - 2 * _stroke,
          height: _height - 2 * _stroke,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(_radius - _stroke)),
            color: color ?? AppColors.solid_white,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xff009dee),
            fontWeight: FontWeight.w400,
            fontFamily: "Poppins",
            fontStyle: FontStyle.normal,
            fontSize: 10.7,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class AppColors {
  static const bg_blue_white = Color(0xfff0f7ff);
  static const breeze_green = Color(0xff6effae);
  static const colors_action_danger = Color(0xffff3a29);
  static const colors_action_primary = Color(0xff4339f2);
  static const colors_action_success = Color(0xff34b53a);
  static const colors_action_warning = Color(0xffffb200);
  static const colors_black_10 = Color(0x1a000000);
  static const colors_black_20 = Color(0x33000000);
  static const colors_light_primary = Color(0xffdad7fe);
  static const deep_blue = Color(0xff006fee);
  static const grey_black = Color(0xff3b3b3b);
  static const menu_icons_not_pushed = Color(0xffc4c4c4);
  static const obsidian = Color(0xff000000);
  static const soft_torqueze = Color(0xff00d1e1);
  static const solid_black_30 = Color(0x4d000000);
  static const solid_blue_talya = Color(0xff1e2647);
  static const solid_ligh_blue_talya = Color(0xff00abd4);
  static const solid_notification_green = Color(0xff29d187);
  static const solid_notification_red = Color(0xffe37473);
  static const solid_red_talya = Color(0xffdb3d3d);
  static const solid_white = Color(0xffffffff);
  static const yellow = Color(0xfffbc54f);
}
