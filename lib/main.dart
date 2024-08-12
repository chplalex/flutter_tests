import 'package:flutter/material.dart';
import 'package:flutter_tests/test_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Tests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestWidget(),
    );
  }
}
