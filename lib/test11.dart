import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'routes.dart';

class Test11 extends StatefulWidget {
  const Test11({super.key});

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<Test11> {
  late final Future<Response> _future;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Test 11: WebView and Html tests", style: Theme.of(context).textTheme.titleLarge),
        ),
        body: Center(child: _buildWidget(context)),
      );

  Widget _buildWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _listTileWebView(context, title: 'RU-Light', content: contentRuLight),
          _listTileHtml(context, title: 'RU-Light', content: contentRuLight),
        ],
      );

  ListTile _listTileWebView(BuildContext context, {required String title, required String content}) => ListTile(
        title: Text('WebView: $title'),
        onTap: () => _navigate(context, routeName: Routes.webview, content: content),
      );

  ListTile _listTileHtml(BuildContext context, {required String title, required String content}) => ListTile(
        title: Text('HTML: $title'),
        onTap: () => _navigate(context, routeName: Routes.html, content: content),
      );

  void _navigate(
    BuildContext context, {
    required String routeName,
    required String content,
  }) =>
      Navigator.of(context).pushNamed(
        routeName,
        arguments: content,
      );
}

const contentRuLight = '''
<p><span style="color:#404040;font-size:18pt;">Вещание интернет радиостанции</span><span style="font-size:18pt;">&nbsp;</span><strong><span style="color:#404040;font-size:18pt;">&laquo;Первое Союзное Радио&raquo;</span></strong><strong><span style="font-size:18pt;">&nbsp;</span></strong><span style="color:#404040;font-size:18pt;">началось 1 марта 2020 года. Нас можно слушать круглосуточно, 7 дней в неделю.</span></p>
<p><span style="color:#404040;font-size:18pt;">Вы узнаете всё о жизни</span><span style="font-size:18pt;">&nbsp;Союзного государства Беларуси и России.&nbsp;</span><span style="color:#404040;font-size:18pt;">Услышите любимые белорусские и российские песни, интервью на актуальные темы и свежие новости.</span></p>
<p><span style="color:#404040;font-size:18pt;">В эфире звучат программы, созданные по заказу</span><span style="font-size:18pt;">&nbsp;Телерадиовещательной Организации Союзного государства&nbsp;</span><span style="color:#404040;font-size:18pt;">и выходящие в эфир на крупнейших радиостанциях России и Беларуси.</span></p>
<p><span style="color:#404040;font-size:18pt;">Каждый час на Первом Союзном Радио выходят свежие выпуски новостей.</span></p>
<p><strong><span style="color:#404040;font-size:18pt;">Россия и Беларусь!</span></strong></p>
<p><strong><span style="color:#404040;font-size:18pt;">Две страны &mdash; одно радио!</span></strong></p>
''';