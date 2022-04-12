import 'package:adeline_project_dev/screen/mobile/character_setting_screen/character_setting_screen.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/gold_contents_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/weekly_contents_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/user/content/gold_content.dart';
import '../../../../model/user/user_provider.dart';
import 'character_slot_widgets/daily_contents_widget.dart';

class CharacterSlotWidget extends StatefulWidget {
  const CharacterSlotWidget({Key? key}) : super(key: key);

  @override
  State<CharacterSlotWidget> createState() => _CharacterSlotWidgetState();
}

class _CharacterSlotWidgetState extends State<CharacterSlotWidget> {
  int tag = 0;
  List<String> options = ['일일', '주간', '골드'];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Expanded(
      child: ListView.builder(
        itemCount: userProvider.charactersProvider.characters.length,
        itemBuilder: (context, characterIndex) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Consumer<UserProvider>(
                  builder: (context, instance, child) {
                    return ExpansionTile(
                      tilePadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.topLeft,
                      textColor: Colors.black,
                      backgroundColor: Colors.white,
                      collapsedIconColor: Colors.grey,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      'assets/job/105.png',
                                      width: 40,
                                      height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(userProvider.charactersProvider.characters[characterIndex].nickName,
                                              style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16)),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                              '${userProvider.charactersProvider.characters[characterIndex].job} Lv.${userProvider.charactersProvider.characters[characterIndex].level} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1
                                                  ?.copyWith(fontSize: 13, color: Colors.grey)),
                                        ],
                                      ),
                                      Text('주간 골드 : ${weeklyGold(characterIndex)} G',
                                          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14)),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/daily/Chaos.png',
                                                width: 22,
                                                height: 22,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5, right: 5),
                                                child: Container(
                                                  width: 30,
                                                  child: Text(
                                                    '${userProvider.charactersProvider.characters[characterIndex].dailyContents[0].restGauge}',
                                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/daily/Guardian.png',
                                                width: 22,
                                                height: 22,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5, right: 5),
                                                child: Container(
                                                  width: 30,
                                                  child: Text(
                                                    '${userProvider.charactersProvider.characters[characterIndex].dailyContents[1].restGauge}',
                                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/daily/Epona.png',
                                                width: 22,
                                                height: 22,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5, right: 5),
                                                child: Container(
                                                  width: 30,
                                                  child: Text(
                                                    '${userProvider.charactersProvider.characters[characterIndex].dailyContents[2].restGauge}',
                                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChipsChoice<int>.single(
                              value: tag,
                              onChanged: (val) {
                                setState(() {
                                  tag = val;
                                });
                              },
                              choiceItems: C2Choice.listFrom<int, String>(
                                source: options,
                                value: (i, v) => i,
                                label: (i, v) => v,
                              ),
                              choiceStyle: C2ChoiceStyle(
                                showCheckmark: false,
                                color: Colors.grey,
                                backgroundColor: Colors.white,
                                borderColor: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                              ),
                              choiceActiveStyle: C2ChoiceStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  showCheckmark: false),
                            ),
                            IconButton(
                              icon: Icon(Icons.settings, color: Colors.grey),
                              onPressed: () {
                                if (userProvider.charactersProvider.characters[characterIndex].goldContents.length == 0) {
                                  userProvider.charactersProvider.characters[characterIndex].goldContents = List.generate(
                                      constGoldContents.length, (index) => GoldContent.clone(constGoldContents[index]));
                                }

                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => CharacterSettingsScreen(characterIndex)));
                              },
                            )
                          ],
                        ),
                        widgetPerContents(options[tag], characterIndex),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget widgetPerContents(String tag, int characterIndex) {
    switch (tag) {
      case "일일":
        return DailyContentsWidget(characterIndex);
      case "주간":
        return WeeklyContentsWidget(characterIndex);
      case "골드":
        return GoldContentsWidget(characterIndex);
    }
    return Container();
  }

  String weeklyGold(int characterIndex) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    int level = int.parse(userProvider.charactersProvider.characters[characterIndex].level.toString());
    int weeklyGold = 0;

    userProvider.charactersProvider.characters[characterIndex].goldContents.forEach(
      (element) {
        if (element.isChecked == true && element.clearChecked == true && (level < element.getGoldLevelLimit)) {
          weeklyGold += element.addGold;
          weeklyGold += element.clearGold;
        }
      },
    );

    return NumberFormat('###,###,###,###').format(weeklyGold).replaceAll(' ', '');
  }
}
