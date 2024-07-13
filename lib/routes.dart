import 'package:flutter/widgets.dart';
import 'package:flutter_tests/test11.dart';

import 'html_page.dart';
import 'web_view_page.dart';

class Routes {
  static const home = '/';
  static const webview = '/webview';
  static const html = '/html';

  Map<String, WidgetBuilder> getRoutes() => {
        Routes.home: (BuildContext context) => const Test11(),
        Routes.webview: (BuildContext context) => const WebViewPage(),
        Routes.html: (BuildContext context) => const HtmlPage(),
      };
}
