import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../model/user/user_provider.dart';

class ContentBoardWidget extends StatefulWidget {
  const ContentBoardWidget({Key? key}) : super(key: key);

  @override
  State<ContentBoardWidget> createState() => _ContentBoardWidgetState();
}

class _ContentBoardWidgetState extends State<ContentBoardWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    print('ContentBoardWidget.dart');
    return Container(
      height: 76,
      margin: EdgeInsets.only(left: 3),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          dumpWidget('발탄', '군단장', userProvider.valTanNormal, userProvider.valTanHard, color: Colors.teal.shade300),
          dumpWidget('비아', '군단장', userProvider.biacKissNormal, userProvider.biacKissHard, color: Colors.deepOrange.shade300),
          dumpWidget('쿠크', '군단장', userProvider.koukoSatonNormal, 0, color: Colors.pinkAccent), // 쿠크는 하드가 없다
          dumpWidget('아브', '군단장', userProvider.abrelshudNormal, userProvider.abrelshudHard, color: Colors.deepPurpleAccent),
          dumpWidget('아르고스', '어비스 레이드', userProvider.argus, 0, color: Colors.blueAccent), // 아르고스는 하드가 없다.
          dumpWidget('오레하', '어비스 던전', userProvider.orehaNormal, userProvider.orehaHard,
              color: DarkMode.isDarkMode.value ? Colors.green : Colors.brown),
        ],
      ),
    );
  }

  Widget dumpWidget(String name, String type, int normal, int hard, {Color color = Colors.grey}) {
    if (type == "어비스 레이드") {
      return Padding(
        padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : color, width: 1),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Text('$name',
                    style:
                        Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14, color: color, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text('횟수', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13)),
                        Text('${normal}', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 2, right: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: DarkMode.isDarkMode.value ? Colors.grey : color, width: 1),
        ),
        child: Column(
          children: [
            Text('$name',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14, color: color, fontWeight: FontWeight.bold)),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('노말', style: Theme.of(context).textTheme.caption),
                      Text('${normal}', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13)),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text('하드', style: Theme.of(context).textTheme.caption),
                      Text('${hard}', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
