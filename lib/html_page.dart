import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';


class HtmlPage extends StatefulWidget {
  const HtmlPage({super.key});

  @override
  State<HtmlPage> createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
  var _content = '';
  var _isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstTime) {
      _isFirstTime = false;
      _content = ModalRoute.of(context)?.settings.arguments as String;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Html(data: _content),
      ),
    );
  }

  Future<String> _loadHtml({required String url}) async {
    final uri = Uri.parse(url);

    final response = await http.get(uri);

    debugPrint("response:\n"
        "  status code: ${response.statusCode}\n"
        "  body: ${response.body}\n");

    final doc = parse(response.body);
    debugPrint('outerHtml: ${doc.outerHtml}\n');

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw 'Failed to load HTML page\n'
          'Status code:\n${response.statusCode}\n'
          'Response body:\n${response.body}';
    }
  }
}
