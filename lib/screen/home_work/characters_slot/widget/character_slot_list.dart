import 'package:adeline_app/constant/constant.dart';
import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/character/character_model.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:adeline_app/model/user/expedition/expedition_model.dart';
import 'package:adeline_app/screen/home_work/character_setting_screen/character_settings_layout.dart';
import 'package:adeline_app/screen/main/mobile/home_screen/widget/admob_widget.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../model/dark_mode/dark_theme_provider.dart';
import '../../../../model/user/content/daily_content.dart';
import '../../../../model/user/content/restGauge_content.dart';
import '../../../../model/user/user_provider.dart';
import 'character_slot_widgets/daily_contents_widget.dart';
import 'character_slot_widgets/raid_contents_widget.dart';
import 'character_slot_widgets/weekly_contents_widget.dart';

class CharacterSlotWidget extends StatefulWidget {
  const CharacterSlotWidget({Key? key}) : super(key: key);

  @override
  State<CharacterSlotWidget> createState() => _CharacterSlotWidgetState();
}

class _CharacterSlotWidgetState extends State<CharacterSlotWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    List<String> possibleGetGoldNameList = Hive.box<Expedition>(hiveExpeditionName).get('expeditionList')!.possibleGoldCharacters;
    return Expanded(
      child: ListView.builder(
        itemCount: userProvider.charactersProvider.characters.length,
        itemBuilder: (context, characterIndex) {
          Character character = userProvider.charactersProvider.characters[characterIndex];
          bool getGoldCheck = possibleGetGoldNameList.contains(character.nickName);

          return Padding(
            padding: const EdgeInsets.fromLTRB(5, 3, 5, 5),
            child: Card(
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              child: Consumer<UserProvider>(
                builder: (context, instance, child) {
                  return ListTileTheme(
                    horizontalTitleGap: 5,
                    dense: true,
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      expandedCrossAxisAlignment: CrossAxisAlignment.start,
                      expandedAlignment: Alignment.topLeft,
                      textColor: Colors.black,
                      backgroundColor: DarkMode.isDarkMode.value ? Color(0xFF212121) : Colors.white,
                      collapsedIconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
                      iconColor: DarkMode.isDarkMode.value ? Colors.white : Colors.grey,
                      leading: Image.asset(
                        'assets/job/${character.jobCode}.png',
                        width: 45,
                        height: 45,
                        color: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  getGoldCheck
                                      ? Padding(
                                          padding: const EdgeInsets.only(right: 3),
                                          child: Image.asset('assets/etc/Gold.png', width: 16, height: 20),
                                        )
                                      : Container(),
                                  Text(character.nickName, style: Theme.of(context).textTheme.bodyText2),
                                  SizedBox(width: 3),
                                  Text('${character.job} Lv.${character.level} ',
                                      style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey)),
                                ],
                              ),
                              Text('주간 골드 : ${userProvider.weeklyGold(characterIndex)} G',
                                  style: Theme.of(context).textTheme.caption),
                              // 카던, 가디언, 에포나 숙제 3종 휴식게이지
                              Row(children: restGaugeNumberWidget(context, characterIndex, character)),
                              SizedBox(height: 2),
                              // 캐릭터 일일/주간/골드 전체클리어 여부를 Chip 으로 보여준다.
                              Row(children: contentSummaryIconWidget(character)),
                            ],
                          ),
                        ],
                      ),
                      // ExpansionTile 확장되면 보여지는 부분
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChipsChoice<int>.single(
                              padding: EdgeInsets.only(left: 2),
                              value: character.tag,
                              onChanged: (val) {
                                setState(() {
                                  character.tag = val;
                                });
                              },
                              choiceItems: C2Choice.listFrom<int, String>(
                                source: character.options,
                                value: (i, v) => i,
                                label: (i, v) => v,
                              ),
                              choiceStyle: C2ChoiceStyle(
                                showCheckmark: false,
                                color: Colors.black,
                                backgroundColor: DarkMode.isDarkMode.value ? Colors.grey : Colors.white,
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
                              icon: Icon(Icons.settings, color: DarkMode.isDarkMode.value ? Colors.white : Colors.grey),
                              onPressed: () {
                                if (character.raidContents.length == 0) {
                                  character.raidContents = List.generate(
                                      constRaidContents.length, (index) => RaidContent.clone(constRaidContents[index]));
                                }
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => CharacterSettingsLayout(characterIndex)));
                              },
                            )
                          ],
                        ),
                        widgetPerContents(character.options[character.tag], characterIndex),
                        Align(alignment: Alignment.center, child: AdmobWidget()),
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
    switch (tag) {
      case "일일":
        return DailyContentsWidget(characterIndex);
      case "주간":
        return WeeklyContentsWidget(characterIndex);
      case "레이드":
        return RaidContentsWidget(characterIndex);
      default:
        return Container();
    }
  }

  String weeklyGold(Character character) {
    int clearGold = 0;
    int bonusGold = 0;
    // 한 캐릭터의 주간 골드
    character.raidContents.forEach((raidContent) {
      for (int i = 0; i < raidContent.clearList.length; i++) {
        if (raidContent.clearList[i].check) {
          clearGold += int.parse(raidContent.reward[raidContent.clearList[i].difficulty]!['클리어골드'][i].toString());
          if (raidContent.bonusList[i].check) {
            bonusGold += int.parse(raidContent.reward[raidContent.bonusList[i].difficulty]!['더보기골드'][i].toString());
          }
        }
      }
      clearGold += raidContent.addGold;
    });
    return NumberFormat('###,###,###,###').format(clearGold - bonusGold);
  }

  List<Widget> restGaugeNumberWidget(BuildContext context, int characterIndex, Character character) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Widget> restGauges = [];
    for (int index = 0; index < 3; index++) {
      if (character.dailyContents[index].isChecked) {
        restGauges.add(Row(
          children: [
            Image.asset(
              'assets/daily/${index}.png',
              width: 20,
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Container(
                width: 30,
                child: Text(
                  '${character.dailyContents[index].restGauge}',
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 14),
                ),
              ),
            ),
          ],
        ));
      }
    }
    return restGauges;
  }

  List<Widget> contentSummaryIconWidget(Character character) {
    List<Widget> summaryIcons = [];
    bool dailyNotClear = false;
    bool dailySummaryIcon = false;
    bool weeklyNotClear = false;
    bool weeklySummaryIcon = false;
    bool goldNotClear = false;
    bool goldSummaryIcon = false;

    character.weeklyContents.forEach(
      (element) {
        if (element.isChecked) {
          character.options.contains('주간') ? null : character.options.insert(0, '주간');
          weeklySummaryIcon = true;
        }
        if (element.isChecked && !element.clearChecked) {
          weeklyNotClear = true;
        }
      },
    );

    character.dailyContents.forEach((element) {
      if (element.isChecked) {
        character.options.contains('일일') ? null : character.options.insert(0, '일일');
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

    character.raidContents.forEach((raidContent) {
      if (raidContent.isChecked) {
        goldSummaryIcon = true;
      }
      if (raidContent.isChecked) {
        for (int i = 0; i < raidContent.clearCheckStandardPhase; i++) {
          if (!raidContent.clearList[i].check) {
            goldNotClear = true;
          }
        }
      }
    });
    if (dailySummaryIcon) {
      summaryIcons.add(Container(
        margin: const EdgeInsets.only(top: 3, right: 5),
        decoration: BoxDecoration(
          border: Border.all(color: DarkMode.isDarkMode.value ? Colors.green : Colors.greenAccent),
          color: DarkMode.isDarkMode.value ? Colors.green : Colors.greenAccent,
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
                        color: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                      ),
                    ),
              SizedBox(
                width: 3,
              ),
              Text(
                '일일',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ));
    }
    if (weeklySummaryIcon) {
      summaryIcons.add(Container(
        margin: const EdgeInsets.only(top: 3, right: 5),
        decoration: BoxDecoration(
          border: Border.all(color: DarkMode.isDarkMode.value ? Colors.red : Colors.lightBlueAccent[100]!),
          color: DarkMode.isDarkMode.value ? Colors.red : Colors.lightBlueAccent[100],
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
                        color: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                      ),
                    ),
              SizedBox(
                width: 3,
              ),
              Text(
                '주간',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ));
    }
    if (goldSummaryIcon) {
      summaryIcons.add(Container(
        margin: const EdgeInsets.only(top: 3, right: 5),
        decoration: BoxDecoration(
          border: Border.all(color: DarkMode.isDarkMode.value ? Colors.orange : Colors.orangeAccent[200]!),
          color: DarkMode.isDarkMode.value ? Colors.orange : Colors.orangeAccent[200],
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
                        color: DarkMode.isDarkMode.value ? Colors.white : Colors.black,
                      ),
                    ),
              SizedBox(width: 3),
              Text(
                '레이드',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ));
    }

    return summaryIcons;
  }
}
