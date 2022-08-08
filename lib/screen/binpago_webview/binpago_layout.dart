import 'package:adeline_app/screen/binpago_webview/mobile_binpago_webview.dart';
import 'package:adeline_app/screen/binpago_webview/not_mobile_binpago_webview.dart';
import 'package:flutter/material.dart';

class BinpagoLayout extends StatefulWidget {
  const BinpagoLayout({Key? key}) : super(key: key);

  @override
  State<BinpagoLayout> createState() => _BinpagoLayoutState();
}

class _BinpagoLayoutState extends State<BinpagoLayout> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return NotMobileBinpagoWebView();
      } else {
        return MobileBinpagoWebView();
      }
    });
  }
}
