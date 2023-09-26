import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fe/store/userstore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class WebviewPage extends StatefulWidget {

  const WebviewPage({super.key, this.url, this.itemId});
  final url;
  final itemId;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
          useHybridComposition: true
      ),
      ios: IOSInAppWebViewOptions(
          allowsAirPlayForMediaPlayback: true
      )
  );

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();


  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }


  Dio dio = Dio();
  final serverURL = 'http://j9c204.p.ssafy.io:8080';

  Future<dynamic> purchaseItem(itemId) async {
    var accessToken = context.read<UserStore>().accessToken;
    print(accessToken);
    if(accessToken != ''){
      try {
        final response = await dio.post('$serverURL/item/purchased', data: {'itemId' : itemId},
          options: Options(
            headers: {'Authorization': 'Bearer $accessToken'},
          ),);
        print(response.data);
        return response.data;
      } catch (e) {
        print(e);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await webViewController?.canGoBack() ?? false) {
          webViewController?.goBack();
          return false;
        } else {
          // WebView에서 뒤로 갈 수 없는 경우에는 앱을 종료합니다.
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  prefixIcon: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close)
                  )
                  ,
                ),
                controller: urlController,
                keyboardType: TextInputType.url,
                onSubmitted: (value) {
                  var url = Uri.parse(value);
                  if (url.scheme.isEmpty) {
                    url = Uri.parse("https://www.google.com/search?q=" + value);
                  }
                  webViewController?.loadUrl(
                      urlRequest: URLRequest(url: url));
                },
              ),
              Expanded(
                child: InAppWebView(
                  key: webViewKey,
                  initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                  initialOptions: options,
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                    controller.addJavaScriptHandler(handlerName: 'onButtonClick', callback: (args){
                      print('Button Clicked: $args');
                      // 뭐샀는지 넣어줘야함!!!!!
                      purchaseItem(1);
                    });
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  androidOnPermissionRequest: (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading: (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
                    if (![ "http", "https", "file", "chrome",
                      "data", "javascript", "about"].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        // Launch the App
                        await launchUrl(uri);
                        return NavigationActionPolicy.CANCEL;
                      } else {

                      }
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (InAppWebViewController controller, Uri? url){
                    controller.evaluateJavascript(source: '''
                    var myButtons = document.querySelectorAll('button');
                    myButtons.forEach(function(button) {
                      button.addEventListener('click', function() {
                      if (button.innerText.includes('구매')) {
                        // 버튼 클릭 이벤트가 발생하면 Flutter 쪽으로 이벤트를 전달합니다.
                        window.flutter_inappwebview.callHandler('onButtonClick', 'Button Clicked')
                        };
                      });
                    });
                  ''');
                  },
                  onLoadError: (controller, url, code, message) {
                    pullToRefreshController.endRefreshing();
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                      urlController.text = this.url;
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {
                    setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print(consoleMessage);
                  },
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
