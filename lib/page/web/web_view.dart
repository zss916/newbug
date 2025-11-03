import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbug/core/widget/index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late WebViewController webViewController;
  String _lastUrl = "";
  String url = "";
  String title = "";
  String javaScriptChannelName = "cv";

  @override
  void initState() {
    super.initState();
    var arguments = Get.arguments as Map<String, dynamic>;
    title = arguments["title"];
    url = arguments["url"];
    initWebController();
  }

  @override
  void dispose() {
    super.dispose();
    webViewController.clearLocalStorage();
    webViewController.clearCache();
    webViewController.removeJavaScriptChannel(javaScriptChannelName);
  }

  void initWebController() {
    webViewController = WebViewController()
      ..addJavaScriptChannel(javaScriptChannelName, onMessageReceived: (e) {})
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            if (!request.url.startsWith('http')) {
              if (await launchUrl(Uri.parse(request.url))) {
                return NavigationDecision.prevent;
              }
            }
            if (_lastUrl == request.url) {
              return NavigationDecision.navigate;
            } else {
              webViewController.loadRequest(
                Uri.parse(request.url),
                headers: {"referer": _lastUrl},
              );
              _lastUrl = request.url;
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    _lastUrl = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: Colors.black,
      body: WebViewWidget(controller: webViewController),
    );
  }
}
