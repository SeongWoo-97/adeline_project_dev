import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BlankScreen extends StatefulWidget {
  const BlankScreen({Key? key}) : super(key: key);

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_BlankScreenState>()?.restartApp();
  }

  @override
  State<BlankScreen> createState() => _BlankScreenState();
}

class _BlankScreenState extends State<BlankScreen> {
  Key key = UniqueKey();
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('새로고침');
    return KeyedSubtree(
      key: key,
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          child: Text('성공!'),
        ),
      ),
    );
  }
}
