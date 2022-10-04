// two pages, pass data from second to first adn update first in the background

// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';

StreamController<String?> _streamController = StreamController();

class Page011 extends StatefulWidget {
  const Page011({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PageState011();
}

class PageState011 extends State<Page011> {

  String? _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Page", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StreamBuilder<String?>(
              stream: _streamController.stream.distinct().asBroadcastStream(),
              builder: (context, snapshot) {
                _text = snapshot.hasData ? snapshot.data : _text;
                final text = _text ?? "Text is null";
                return Text(text, style: Theme.of(context).textTheme.headline4);
              }
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => Page012(_text),
              )),
              child: Text("Open the Second Page", style: Theme.of(context).textTheme.button),
            )
          ],
        ),
      ),
    );
  }
}

class Page012 extends StatefulWidget {
  final String? _initText;

  const Page012(this._initText, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PageState012();
}

class PageState012 extends State<Page012> {
  String? _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Page", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(initialValue: widget._initText, onChanged: (text) => _text = text),
            ),
            ElevatedButton(
              onPressed: () => _streamController.add(_text),
              child: Text("Push Text to the First page", style: Theme.of(context).textTheme.button),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Return to the First page", style: Theme.of(context).textTheme.button),
            )
          ],
        ),
      ),
    );
  }
}
