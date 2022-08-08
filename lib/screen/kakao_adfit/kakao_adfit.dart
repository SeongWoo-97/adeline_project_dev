
import 'dart:html';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class KaKaoAdfitBanner extends StatelessWidget {
  const KaKaoAdfitBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdIframe();
  }

  AdIframe() {
    ui.platformViewRegistry.registerViewFactory(
        'adViewType',
        (int viewID) => IFrameElement()
          ..width = '728'
          ..height = '90'
          ..src = 'adfit_728x90.html'
          ..style.border = 'none');
    return Container(width: 750,height: 110, child: HtmlElementView(viewType: 'adViewType'));
  }
}
