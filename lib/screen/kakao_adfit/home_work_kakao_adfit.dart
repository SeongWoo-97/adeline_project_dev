import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class KakaoAdfitHomeWork extends StatelessWidget {
  const KakaoAdfitHomeWork({Key? key}) : super(key: key);

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
          ..src = 'adfit_home_work.html'
          ..style.border = 'none');
    return Container(width: 740,height: 110, child: HtmlElementView(viewType: 'adViewType'));
  }
}
