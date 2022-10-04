// two pages, pass data from second to first adn update first in the background

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Page02 extends StatefulWidget {
  const Page02({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageState02();
}

class _PageState02 extends State<Page02> {
  final _controller = ScrollController();

  void _scrollToMiddle() async {
    _controller.animateTo(
      _controller.position.maxScrollExtent / 2,
      duration: const Duration(milliseconds: 350),
      curve: Curves.decelerate,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToMiddle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test 02", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Stack(
        children: [
          _scrollWidget(context),
          Align(
            alignment: Alignment.bottomRight,
            child: _middleButton(context),
          )
        ],
      ),
    );
  }

  Widget _scrollWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: CupertinoColors.lightBackgroundGray,
      child: ListWheelScrollView(
        controller: _controller,
        itemExtent: 250,
        diameterRatio: 2.5,
        useMagnifier: true,
        magnification: 1.5,
        squeeze: 0.75,
        children: [
          _elementPrev(context),
          _elementNow(context),
          _elementNext(context),
        ],
      ),
    );
  }

  Widget _elementPrev(BuildContext context) {
    return _element(
      context,
      imageSource: "assets/images/talk_01.png",
      headerText: "Ранее в эфире",
      titleText: "Title prev",
      artistText: "Artist prev",
    );
  }

  Widget _elementNow(BuildContext context) {
    return _element(
      context,
      imageSource: "assets/images/music_01.png",
      headerText: "Сейчас в эфире",
      titleText: "Title now",
      artistText: "Artist now",
    );
  }

  Widget _elementNext(BuildContext context) {
    return _element(
      context,
      imageSource: "assets/images/news_01.png",
      headerText: "Далее в эфире",
      titleText: "Title next",
      artistText: "Artist next",
    );
  }

  Widget _element(
    BuildContext context, {
    required String imageSource,
    required String headerText,
    required String titleText,
    required String artistText,
  }) {
    const imageSize = 150.0;
    final image = Image.asset(
      imageSource,
      width: imageSize,
      height: imageSize,
      fit: BoxFit.cover,
    );
    final style = Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16.0);
    final header = Text(headerText, style: style);
    final title = Text(titleText, style: style);
    final artist = Text(artistText, style: style);

    return Container(
      alignment: Alignment.center,
      width: 200,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: CupertinoColors.inactiveGray),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          header,
          image,
          title,
          artist,
        ],
      ),
    );
  }

  Widget _middleButton(BuildContext context) {
    const buttonSize = 35.0;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () => _scrollToMiddle(),
        child: Container(
          alignment: Alignment.center,
          height: buttonSize,
          width: buttonSize,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }
}
