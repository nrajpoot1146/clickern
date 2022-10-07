import 'dart:async';

import 'package:clickern/main.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

class WebView extends StatefulWidget {
  WebView(
      {Key? key,
      required this.url,
      required this.linkDetails,
      this.isEnableTimer = false})
      : super(key: key);

  final String url;
  final linkDetails;
  final bool isEnableTimer;

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  _WebViewState();
  late InAppWebViewController _webViewController;
  double progress = 0.0;
  bool isEnableTimer = false;
  bool flag = true;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  int _countDown = 10;
  Timer? _timer;
  bool isBackEnabled = false;
  Uri? _uri;

  @override
  void initState() {
    super.initState();
    isBackEnabled = !widget.isEnableTimer;
    isEnableTimer = !isEnableTimer;
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (timer) {
        if (_countDown == 0) {
          var url = _uri.toString();
          String targetUrl = widget.linkDetails['target_link'];
          String mTargetUrl = "";
          if (targetUrl.contains('www')) {
            mTargetUrl = targetUrl.replaceFirst('www', 'm');
          }

          if ((url == targetUrl ||
                  url == mTargetUrl ||
                  url.contains(targetUrl)) &&
              flag) {
            http.post(
              Uri.parse(API_URL + '/increaseCount'),
              body: {
                'sessionId': sessionId,
                'linkId': widget.linkDetails['link_id']
              },
            ).then(
              (value) {},
            );

            flag = false;
          }
          setState(
            () {
              isBackEnabled = true;
            },
          );
          timer.cancel();
        } else {
          setState(
            () {
              _countDown--;
            },
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browser'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: const <Widget>[
          // NavigationControls(_controller.future),
          // SampleMenu(_controller.future),
        ],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            children: [
              progress < 1.0
                  ? LinearProgressIndicator(
                      value: progress,
                    )
                  : Container(),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)),
                  child: InAppWebView(
                    initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        supportZoom: true,
                        javaScriptEnabled: true,
                        //contentBlockers: [ContentBlocker(trigger: trigger, action: action)]
                        javaScriptCanOpenWindowsAutomatically: true,
                        useShouldOverrideUrlLoading: true,
                        useOnLoadResource: true,
                        userAgent:
                            "Mozilla/5.0 (Linux; Android 9; LG-H870 Build/PKQ1.190522.001) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/83.0.4103.106 Mobile Safari/537.36",
                      ),
                      android: AndroidInAppWebViewOptions(
                        useWideViewPort: true,
                        initialScale: 1,
                        //safeBrowsingEnabled: true,
                        // disableDefaultErrorPage: true,

                        supportMultipleWindows: true,
                        //useHybridComposition: true,
                        verticalScrollbarThumbColor:
                            const Color.fromRGBO(0, 0, 0, 0.5),
                        horizontalScrollbarThumbColor:
                            const Color.fromRGBO(0, 0, 0, 0.5),
                        domStorageEnabled: true,
                      ),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      _webViewController = controller;
                    },
                    onLoadStart: (controller, uri) {
                      // if (uri.toString().contains('sg.cmclean.club')) {
                      //   controller.stopLoading();
                      //   print('unwanted url found');
                      // }
                    },
                    onLoadStop: (controller, uri) {
                      _uri = uri;
                      // print("")
                      if (widget.isEnableTimer) startTimer();
                    },
                    onCreateWindow: (controller, onCreateWindowRequest) async {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 700,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: InAppWebView(
                                      windowId: onCreateWindowRequest.windowId,
                                      initialUrlRequest:
                                          onCreateWindowRequest.request.url !=
                                                  null
                                              ? URLRequest(
                                                  url: onCreateWindowRequest
                                                      .request.url)
                                              : null,
                                      initialOptions: InAppWebViewGroupOptions(
                                          crossPlatform: InAppWebViewOptions(
                                              // debuggingEnabled: true,
                                              useShouldOverrideUrlLoading:
                                                  true)),
                                      onLoadStart: (controller, uri) {},
                                      onWebViewCreated: (controller) => {},
                                      onLoadStop: (controller, url) async {
                                        _uri = url;
                                        // print("")
                                        if (widget.isEnableTimer) startTimer();
                                        if (url.toString() == "myURL") {
                                          Navigator.pop(context);
                                          return;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                      return true;
                    },
                    onProgressChanged:
                        (InAppWebViewController controller, int p) {
                      setState(
                        () {
                          progress = p / 100;
                        },
                      );
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isBackEnabled == false
                        ? null
                        : () {
                            _webViewController.goBack();
                          },
                    child: const Text("back"),
                  ),
                  Text(" $_countDown "),
                  ElevatedButton(
                      onPressed: () {
                        _webViewController.reload();
                      },
                      child: const Text("Reload")),
                ],
              )
            ],
          );
        },
      ),
      //floatingActionButton: favoriteButton(),
    );
  }
}
