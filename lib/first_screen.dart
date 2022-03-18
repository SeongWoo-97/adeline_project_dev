import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Flutter Demo'),
      ),
      // material: (_, __) => MaterialScaffoldData(
      //   body: Center(child: Text('하이',style: Theme.of(context).textTheme.bodyText1,)),
      // ),
      // cupertino: (_, __) => CupertinoPageScaffoldData(
      //   body: Center(child: Text('하이')),
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              PlatformWidget(
                material: (_,__) => Text('안녕'),
                cupertino: (_,__) => Text('하세요'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
