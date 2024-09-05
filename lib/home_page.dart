import 'package:flutter/material.dart';
import 'package:flutter_tests/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: TextButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.work),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: const Text('Go to Work'),
        ),
      ),
    );
  }
}
