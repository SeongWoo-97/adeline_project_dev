import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MobileBinpagoWebView extends StatefulWidget {
  const MobileBinpagoWebView({Key? key}) : super(key: key);

  @override
  _MobileBinpagoWebViewState createState() => _MobileBinpagoWebViewState();
}

class _MobileBinpagoWebViewState extends State<MobileBinpagoWebView> {
  bool isLoading = true;
  String url = 'https://ialy1595.me/kouku/';
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(
          '쿠크세이튼 빙고 도우미',
        ),
        material: (_, __) => MaterialAppBarData(actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                isLoading = true;
                _webViewController.reload();
              });
            },
          ),
        ]),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return SafeArea(
            child: Stack(children: [
              WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
                onPageFinished: (finish) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Stack(),
            ]),
          );
        },
      ),
    );
  }
}
