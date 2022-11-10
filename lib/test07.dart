// deep link tests

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';

class Test07 extends StatefulWidget {
  const Test07({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test07> with WidgetsBindingObserver {
  Uri? _uri;
  late final StreamSubscription<Uri?> _streamSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _streamSubscription = uriLinkStream.listen((uri) => setState(() {
          debugPrint("uriLinkStream event => uri = $uri");
          _uri = uri;
        }));

    getInitialUri().then((uri) => setState(() {
          debugPrint("getInitialUri => uri = $uri");
          _uri = uri;
        }));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    debugPrint("didChangeAppLifecycleState() => state = $state");
    if (state == AppLifecycleState.resumed) {
      debugPrint("didChangeAppLifecycleState() => the app activated");
      setState(() {});
    }
    if (state == AppLifecycleState.paused) {
      debugPrint("didChangeAppLifecycleState() => the app paused");
      _uri = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Test 07: Deep links", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: Center(child: _buildDataWidget(_uri)),
      ),
    );
  }

  Widget _buildDataWidget(Uri? uri) {
    final text = uri != null ? "The app started by deeplink:\n\n\"${uri.origin}\"" : "The app started by user";
    return Text(text, textAlign: TextAlign.center);
  }
}
