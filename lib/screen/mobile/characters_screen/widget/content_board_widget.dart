import 'package:adeline_project_dev/model/user/content/gold_content.dart';
import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';

class ContentBoardWidget extends StatefulWidget {
  const ContentBoardWidget({Key? key}) : super(key: key);

  @override
  State<ContentBoardWidget> createState() => _ContentBoardWidgetState();
}

class _ContentBoardWidgetState extends State<ContentBoardWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Container(
      height: 76,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          dumpWidget('발탄', valTanNormal, valTanHard, color: Colors.teal.shade300),
          dumpWidget('비아', biacKissNormal, biacKissHard, color: Colors.deepOrange.shade300),
          dumpWidget('쿠크', koukoSatonNormal, ValueNotifier<int>(0), color: Colors.pinkAccent),
          dumpWidget('아브', abrelshudNormal, abrelshudHard, color: Colors.deepPurpleAccent),
          dumpWidget('알고', argus, ValueNotifier<int>(0), color: Colors.blueAccent),
          dumpWidget('오레하', orehaNormal, orehaHard, color: Colors.brown),
        ],
      ),
    );
  }

  Widget dumpWidget(String name, ValueNotifier<int> normal, ValueNotifier<int> hard, {Color color = Colors.grey}) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: color, width: 1),
        ),
        elevation: 2,
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
                      Text('노말', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13)),
                      ValueListenableBuilder(
                        valueListenable: normal,
                        builder: (BuildContext context, int value, Widget? child) {
                          return Text('${normal.value}', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13));
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text('하드', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13)),
                      ValueListenableBuilder(
                        valueListenable: hard,
                        builder: (BuildContext context, int value, Widget? child) {
                          return Text('${hard.value}', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13));
                        },
                      ),
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
