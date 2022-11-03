// deep link tests

import 'package:flutter/material.dart';

class Test07 extends StatelessWidget {
  const Test07({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test 07: Deep links", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: const Align(
          alignment: Alignment.center,
          child: Text("The app was started by deep link"),
        ),
      ),
    );
  }
}