import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test - Open mail app", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: InkWell(
          onTap: _onTap,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: Colors.blue,
            ),
            child: const Text('Open Mail app'),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (Platform.isAndroid) {
      const AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: 'android.intent.category.APP_EMAIL',
        flags: [Flag.FLAG_ACTIVITY_NEW_TASK],
      ).launch().then((_) {
        debugPrint('Launch success');
      }).catchError((error) {
        debugPrint('Launch error: $error');
      });
    }

    if (Platform.isIOS) {
      launchUrl(Uri.parse("message://")).then((result) {
        debugPrint('Launch result: $result');
        return Future.value(result);
      }).catchError((error) {
        debugPrint('Launch error: $error');
        return Future.value(false);
      });
    }
  }
}
