import 'package:adeline_project_dev/model/user/content/restGauge_content.dart';
import 'package:adeline_project_dev/screen/mobile/character_setting_screen/character_setting_screen.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/gold_contents_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widgets/weekly_contents_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constant/constant.dart';
import '../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../model/user/content/daily_content.dart';
import '../../../../model/user/content/gold_content.dart';
import '../../../../model/user/user_provider.dart';
import 'character_slot_widgets/daily_contents_widget.dart';

class CharacterSlotWidget extends StatefulWidget {
  const CharacterSlotWidget({Key? key}) : super(key: key);

  @override
  State<CharacterSlotWidget> createState() => _CharacterSlotWidgetState();
}

class _CharacterSlotWidgetState extends State<CharacterSlotWidget> {
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
                  bool weeklyNotClear = false;
                  bool dailyNotClear = false;
                  bool goldNotClear = false;
                  bool dailySummaryIcon = false;
                  bool weeklySummaryIcon = false;
                  bool goldSummaryIcon = false;
                  userProvider.charactersProvider.characters[characterIndex].dailyContents.forEach((element) {
                    if (element.isChecked) {
                      userProvider.charactersProvider.characters[characterIndex].options.contains('일일')
                          ? null
                          : userProvider.charactersProvider.characters[characterIndex].options.insert(0, '일일');
                      dailySummaryIcon = true;
                    }
                    if (element is DailyContent) {
                      if (element.isChecked && !element.clearChecked) {
                        dailyNotClear = true;
                      }
                    } else {
                      if (element is RestGaugeContent) {
                        if (element.isChecked && !(element.clearNum == element.maxClearNum)) {
                          dailyNotClear = true;
                        }
                      }
                    }
                  });
                  userProvider.charactersProvider.characters[characterIndex].weeklyContents.forEach((element) {
                    if (element.isChecked) {
                      userProvider.charactersProvider.characters[characterIndex].options.contains('주간')
                          ? null
                          : userProvider.charactersProvider.characters[characterIndex].options.insert(0, '주간');
                      weeklySummaryIcon = true;
                    }
                    if (element.isChecked && !element.clearChecked) {
                      weeklyNotClear = true;
                    }
                  });

                  userProvider.charactersProvider.characters[characterIndex].goldContents.forEach((element) {
                    if (element.isChecked) {
                      goldSummaryIcon = true;
                    }
                    if (element.isChecked && !element.clearChecked) {
                      goldNotClear = true;
                    }
                  });
                  return ListTileTheme(
                    horizontalTitleGap: 5,
                    dense: true,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
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
                        color: themeProvider.darkTheme ? Colors.white : Colors.black,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13, height: 1.3),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
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
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                children: [
                                  dailySummaryIcon
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 3, right: 5),
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: themeProvider.darkTheme ? Colors.green : Colors.greenAccent),
                                            color: themeProvider.darkTheme ? Colors.green : Colors.greenAccent,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 1, 3, 1),
                                            child: Row(
                                              children: [
                                                dailyNotClear
                                                    ? Container()
                                                    : Padding(
                                                        padding: const EdgeInsets.only(left: 3),
                                                        child: Icon(
                                                          Icons.check,
                                                          size: 12,
                                                          color: themeProvider.darkTheme ? Colors.white : Colors.black,
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  '일일',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      ?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  weeklySummaryIcon
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 3, right: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: themeProvider.darkTheme ? Colors.red : Colors.lightBlueAccent[100]!),
                                            color: themeProvider.darkTheme ? Colors.red : Colors.lightBlueAccent[100],
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 1, 3, 1),
                                            child: Row(
                                              children: [
                                                weeklyNotClear
                                                    ? Container()
                                                    : Padding(
                                                        padding: const EdgeInsets.only(left: 3),
                                                        child: Icon(
                                                          Icons.check,
                                                          size: 12,
                                                          color: themeProvider.darkTheme ? Colors.white : Colors.black,
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  '주간',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      ?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  goldSummaryIcon
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 3, right: 5),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: themeProvider.darkTheme ? Colors.orange : Colors.orangeAccent[200]!),
                                            color: themeProvider.darkTheme ? Colors.orange : Colors.orangeAccent[200],
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(0, 1, 3, 1),
                                            child: Row(
                                              children: [
                                                goldNotClear
                                                    ? Container()
                                                    : Padding(
                                                        padding: const EdgeInsets.only(left: 3),
                                                        child: Icon(
                                                          Icons.check,
                                                          size: 12,
                                                          color: themeProvider.darkTheme ? Colors.white : Colors.black,
                                                        ),
                                                      ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  '골드',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      ?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
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
                              padding: EdgeInsets.only(left: 2),
                              value: userProvider.charactersProvider.characters[characterIndex].tag,
                              onChanged: (val) {
                                setState(() {
                                  userProvider.charactersProvider.characters[characterIndex].tag = val;
                                });
                              },
                              choiceItems: C2Choice.listFrom<int, String>(
                                source: userProvider.charactersProvider.characters[characterIndex].options,
                                value: (i, v) => i,
                                label: (i, v) => v,
                              ),
                              choiceStyle: C2ChoiceStyle(
                                showCheckmark: false,
                                color: Colors.black,
                                backgroundColor: themeProvider.darkTheme ? Colors.grey : Colors.white,
                                borderColor: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              choiceActiveStyle: C2ChoiceStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.white,
                                  borderColor: Colors.black,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
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
                        widgetPerContents(
                            userProvider.charactersProvider.characters[characterIndex]
                                .options[userProvider.charactersProvider.characters[characterIndex].tag],
                            characterIndex),
                      ],
                    ),
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
    print('index : $tag');
    switch (tag) {
      case "일일":
        return DailyContentsWidget(characterIndex);
      case "주간":
        return WeeklyContentsWidget(characterIndex);
      case "골드":
        return GoldContentsWidget(characterIndex);
      default:
        print('default : $tag');
        return Container();
    }
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
            (level >= element.enterLevelLimit)) {
          weeklyGold += element.addGold;
          weeklyGold += element.clearGold;
        }
      },
    );

    return NumberFormat('###,###,###,###').format(weeklyGold).replaceAll(' ', '');
  }
}
