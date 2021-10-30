import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  const WebViewExample({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  _WebViewExampleState();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter WebView example'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: const <Widget>[
          // NavigationControls(_controller.future),
          // SampleMenu(_controller.future),
        ],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            //print("WebView is loading (progress : $progress%)");
          },
          // javascriptChannels: <JavascriptChannel>{
          //   _toasterJavascriptChannel(context),
          // },
          // navigationDelegate: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     print('blocking navigation to $request}');
          //     return NavigationDecision.prevent;
          //   }
          //   print('allowing navigation to $request');
          //   //return NavigationDecision.navigate;
          // },
          onPageStarted: (String url) {
            // print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            //  print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
      //floatingActionButton: favoriteButton(),
    );
  }
}
