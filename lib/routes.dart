import 'package:flutter/material.dart';
import 'package:flutter_tests/work_page.dart';

import 'home_page.dart';

class Routes {
  static const home = '/';
  static const work = '/work';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.home: (context) => const HomePage(),
      Routes.work: (context) => const WorkPage(),
    };
  }
}
