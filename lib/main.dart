import 'package:flutter/material.dart';
import 'package:flutter_tests/test11.dart';

import 'routes.dart';

// HttpProxy? httpProxy;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // httpProxy = await HttpProxy.createHttpProxy();
  // HttpOverrides.global = httpProxy;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routes = Routes();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _routes.getRoutes(),
    );
  }
}
