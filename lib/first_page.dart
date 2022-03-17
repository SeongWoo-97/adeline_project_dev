import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text('First Page'),),
      body: Center(
        child: Text('Material First Page',style: Theme.of(context).textTheme.bodyText1,),
      ),
      material: (_,__) => MaterialScaffoldData(
        body: Center(
          child: Text('Material First Page2',style: Theme.of(context).textTheme.bodyText1,),
        ),
      ),
      cupertino: (_,__) => CupertinoPageScaffoldData(),
    );
  }
}
