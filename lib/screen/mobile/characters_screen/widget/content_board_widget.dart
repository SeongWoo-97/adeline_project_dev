import 'package:adeline_project_dev/model/user/content/gold_content.dart';
import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContentBoardWidget extends StatefulWidget {
  const ContentBoardWidget({Key? key}) : super(key: key);

  @override
  State<ContentBoardWidget> createState() => _ContentBoardWidgetState();
}

class _ContentBoardWidgetState extends State<ContentBoardWidget> {
  @override
  Widget build(BuildContext context) {
    late UserProvider userProvider = Provider.of<UserProvider>(context);
    int valTanNormal = 0;
    int valTanHard = 0;
    int biacKissNormal = 0;
    int biacKissHard = 0;
    int koukoSatonNormal = 0;
    int abrelshudNormal = 0;
    int abrelshudHard = 0;
    int orehaNormal = 0;
    int orehaHard = 0;
    int argus = 0;
    for (int i = 0; i < userProvider.charactersProvider.characters.length; i++) {
      for (int j = 0; j < userProvider.charactersProvider.characters[i].goldContents.length; j++) {
        GoldContent goldContent = userProvider.charactersProvider.characters[i].goldContents[j];
        switch (goldContent.name) {
          case "발탄":
            if (goldContent.isChecked && goldContent.difficulty == "노말") {
              valTanNormal += 1;
            } else if (goldContent.isChecked && goldContent.difficulty == "하드") {
              valTanHard += 1;
            }
            break;
          case "비아키스":
            if (goldContent.isChecked && goldContent.difficulty == "노말") {
              biacKissNormal += 1;
            } else if (goldContent.isChecked && goldContent.difficulty == "하드") {
              biacKissHard += 1;
            }
            break;
          case "쿠크세이튼":
            if (goldContent.isChecked && goldContent.difficulty == "노말") {
              koukoSatonNormal += 1;
            }
            break;
          case "아브렐슈드":
            if (goldContent.isChecked && goldContent.difficulty == "노말") {
              abrelshudNormal += 1;
            } else if (goldContent.isChecked && goldContent.difficulty == "하드") {
              abrelshudHard += 1;
            }
            break;
          case "아르고스":
            argus += 1;
            break;
          case "오레하의 우물":
            if (goldContent.isChecked && goldContent.difficulty == "노말") {
              orehaNormal += 1;
            } else if (goldContent.isChecked && goldContent.difficulty == "하드") {
              orehaHard += 1;
            }
        }
      }
    }
    return Container(
      height: 76,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          dumpWidget('발탄', valTanNormal, valTanHard, color: Colors.teal.shade300),
          dumpWidget('비아', biacKissNormal, biacKissHard, color: Colors.deepOrange.shade300),
          dumpWidget('쿠크', koukoSatonNormal, 0, color: Colors.pinkAccent),
          dumpWidget('아브', abrelshudNormal, abrelshudHard, color: Colors.deepPurpleAccent),
          dumpWidget('알고', argus, 0, color: Colors.blueAccent),
          dumpWidget('오레하', orehaNormal, orehaHard, color: Colors.brown),
        ],
      ),
    );
  }

  Widget dumpWidget(String name, int normal, int hard, {Color color = Colors.grey}) {
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
                      Text('$normal', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13))
                    ],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Text('하드', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13)),
                      Text('$hard', style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
