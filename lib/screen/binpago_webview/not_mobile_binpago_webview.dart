// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
//
// class NotMobileBinpagoWebView extends StatefulWidget {
//   const NotMobileBinpagoWebView({Key? key}) : super(key: key);
//
//   @override
//   State<NotMobileBinpagoWebView> createState() => _NotMobileBinpagoWebViewState();
// }
//
// class _NotMobileBinpagoWebViewState extends State<NotMobileBinpagoWebView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('쿠크세이튼 빙고 도우미'),
//         actions: [
//           Container(
//             alignment: Alignment.center,
//             margin: const EdgeInsets.only(right: 10),
//             child: Text('제작자 - BONHO GOO'),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Center(child: CircularProgressIndicator()),
//           Iframe(),
//         ],
//       ),
//     );
//   }
//   Iframe() {
//     ui.platformViewRegistry.registerViewFactory(
//         'iframe',
//         (int viewId) => IFrameElement()
//           ..width = '640'
//           ..height = '360'
//           ..src = 'https://ialy1595.me/kouku'
//           ..style.border = 'none');
//     return HtmlElementView(viewType: 'iframe',);
//   }
// }
