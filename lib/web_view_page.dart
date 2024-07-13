import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          debugPrint("The page loading progress: $progress");
        },
        onPageStarted: (url) {
          _isLoadError = false;
          debugPrint("The page loading started, url: $url");
        },
        onPageFinished: (url) {
          final success = !_isLoadError;
          debugPrint("The page loading finished, success: $success, url: $url");
        },
        onWebResourceError: (WebResourceError error) {
          _isLoadError = true;
          debugPrint("The page loading error => "
              "code: ${error.errorCode}, "
              "type: ${error.errorType}, "
              "description: ${error.description}, "
              "url: ${error.url}"
              "isForMainFrame: ${error.isForMainFrame}");
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );

  var _isLoadError = false;
  var _isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstTime) {
      _isFirstTime = false;
      final htmlString = ModalRoute.of(context)?.settings.arguments as String;
      _controller.loadHtmlString(htmlString);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: WebViewWidget(controller: _controller)));
  }
}
