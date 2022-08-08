import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CharSearchKakaoAdfit extends StatelessWidget {
  const CharSearchKakaoAdfit({Key? key}) : super(key: key);

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
          ..src = 'adfit_char_search.html'
          ..style.border = 'none');
    return Container(width: 740,height: 110, child: HtmlElementView(viewType: 'adViewType'));
  }
}
