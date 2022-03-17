import 'package:adeline_project_dev/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      material: (_, __) => MaterialAppData(
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.indigo, fontSize: 28),
          ),
        ),
        home: FirstPage(),
      ),
      cupertino: (_, __) => CupertinoAppData(
        theme: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            textStyle: TextStyle(color: Colors.red),
          ),
        ),
      ),
      home: PlatformScaffold(
        appBar: PlatformAppBar(
          title: PlatformText(
            'Flutter Demo',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        body: Center(
          child: Text(
            'Noraml 하이',
          ),
        ),
      ),
    );
  }
}
