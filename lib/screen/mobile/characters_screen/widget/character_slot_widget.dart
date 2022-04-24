import 'package:adeline_project_dev/screen/mobile/character_setting_screen/character_setting_screen.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/gold_contents_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/weekly_contents_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/dark_mode/dark_theme_provider.dart';
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
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Expanded(
      child: ListView.builder(
        itemCount: userProvider.charactersProvider.characters.length,
        itemBuilder: (context, characterIndex) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              child: Consumer<UserProvider>(
                builder: (context, instance, child) {
                  return ExpansionTile(
                    tilePadding: EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    expandedAlignment: Alignment.topLeft,
                    textColor: Colors.black,
                    backgroundColor: themeProvider.darkTheme ? Colors.grey[800] : Colors.white,
                    collapsedIconColor: themeProvider.darkTheme ? Colors.white : Colors.grey,
                    iconColor: themeProvider.darkTheme ? Colors.white : Colors.grey,
                    leading: Image.asset(
                      'assets/job/${userProvider.charactersProvider.characters[characterIndex].jobCode}.png',
                      width: 45,
                      height: 45,
                    ),
                    title: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(userProvider.charactersProvider.characters[characterIndex].nickName,
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15)),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                        '${userProvider.charactersProvider.characters[characterIndex].job} Lv.${userProvider.charactersProvider.characters[characterIndex].level} ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.copyWith(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                                Text(
                                  '주간 골드 : ${weeklyGold(characterIndex)} G',
                                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13,height: 1.3),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        userProvider.charactersProvider.characters[characterIndex].dailyContents[0].isChecked
                            ? Row(
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
                              )
                            : Container(),
                        userProvider.charactersProvider.characters[characterIndex].dailyContents[1].isChecked
                            ? Row(
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
                              )
                            : Container(),
                        userProvider.charactersProvider.characters[characterIndex].dailyContents[2].isChecked
                            ? Row(
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
                              )
                            : Container(),
                      ],
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ChipsChoice<int>.single(
                            padding: EdgeInsets.only(left: 2),
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
                              color: Colors.black,
                              backgroundColor: themeProvider.darkTheme ? Colors.grey : Colors.white,
                              borderColor: Colors.grey,
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            choiceActiveStyle: C2ChoiceStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                                borderColor: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                showCheckmark: false),
                          ),
                          IconButton(
                            icon: Icon(Icons.settings, color: themeProvider.darkTheme ? Colors.white : Colors.grey),
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
        if (element.isChecked == true &&
            element.clearChecked == true &&
            (level < element.getGoldLevelLimit) &&
            (level > element.enterLevelLimit)) {
          weeklyGold += element.addGold;
          weeklyGold += element.clearGold;
        }
      },
    );

    return NumberFormat('###,###,###,###').format(weeklyGold).replaceAll(' ', '');
  }
}
