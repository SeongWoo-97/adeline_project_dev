import 'package:adeline_app/constant/constant.dart';
import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/character/character_model.dart';
import 'package:adeline_app/model/user/content/daily_content.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:adeline_app/model/user/content/restGauge_content.dart';
import 'package:adeline_app/model/user/expedition/expedition_model.dart';
import 'package:adeline_app/model/user/user_provider.dart';
import 'package:adeline_app/screen/home_work/character_setting_screen/character_settings_layout.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/character_slot_widget/not_mobile_daily_contents.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/character_slot_widget/not_mobile_raid_contents.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/character_slot_widget/not_mobile_weekly_contents.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotMobileCharacterSlotListWidget extends StatefulWidget {
  const NotMobileCharacterSlotListWidget({Key? key}) : super(key: key);

  @override
  State<NotMobileCharacterSlotListWidget> createState() => _NotMobileCharacterSlotListWidgetState();
}

class _NotMobileCharacterSlotListWidgetState extends State<NotMobileCharacterSlotListWidget> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    List<String> possibleGetGoldNameList = Hive.box<Expedition>(hiveExpeditionName).get('expeditionList')!.possibleGoldCharacters;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: userProvider.charactersProvider.characters.isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    flex: 3,
                    child: ListView.separated(
                      itemCount: userProvider.charactersProvider.characters.length,
                      shrinkWrap: true,
                      itemBuilder: (context, characterIndex) {
                        Character character = userProvider.charactersProvider.characters[characterIndex];
                        bool getGoldCheck = possibleGetGoldNameList.contains(character.nickName);
                        return InkWell(
                          child: Container(
                            color: userProvider.selectedIndex == characterIndex ? Colors.black26 : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Image.asset(
                                          'assets/job/${character.jobCode}.png',
                                          width: 55,
                                          height: 60,
                                          color: Colors.white,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                getGoldCheck
                                                    ? Padding(
                                                      padding: const EdgeInsets.only(right: 5),
                                                      child: Image.asset('assets/etc/Gold.png', width: 25, height: 20),
                                                    )
                                                    : Container(),
                                                Text(character.nickName, style: Theme.of(context).textTheme.bodyText2),
                                              ],
                                            ),
                                            Text('Lv.${character.level} ${character.job} ',
                                                style: Theme.of(context).textTheme.caption?.copyWith(color: Colors.grey)),
                                            Text('주간 골드 : ${userProvider.weeklyGold(characterIndex)} G',
                                                style: Theme.of(context).textTheme.caption),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5, top: 5),
                                      child: InkWell(
                                        child: Icon(
                                          Icons.settings,
                                          size: 23,
                                        ),
                                        onTap: () {
                                          if (character.raidContents.length == 0) {
                                            character.raidContents = List.generate(
                                                constRaidContents.length, (index) => RaidContent.clone(constRaidContents[index]));
                                          }
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => CharacterSettingsLayout(characterIndex)));
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: contentSummaryIconWidget(character)),
                                      Row(children: restGaugeNumberWidget(context, characterIndex, character)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              userProvider.selectedIndex = characterIndex;
                            });
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Divider(height: 5, thickness: 2),
                        );
                      },
                    ),
                  ),
                  Flexible(
                    flex: 7,
                    child: Card(
                      margin: const EdgeInsets.only(left: 10),
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      '일일 콘텐츠',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  NotMobileDailyContentsWidget(userProvider.selectedIndex),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      '주간 콘텐츠',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  NotMobileWeeklyContentsWidget(userProvider.selectedIndex),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    child: Text(
                                      '레이드 콘텐츠',
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                  // setState Rebuild 만 되지 createState 부터 새로 시작되는것이 아니기 때문에 아래의 코드처럼 사용하지 않으면
                                  // selectedIndex 가 변함에도 같은 인스턴스를 공유하기 때문에 버그가 발생한다.
                                  NotMobileRaidContentsWidget(
                                      userProvider.selectedIndex,
                                      List.generate(
                                          constRaidContents.length, (index) => RaidContent.clone(constRaidContents[index]))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: Text('캐릭터가 존재하지 않습니다.'),
              ),
      ),
    );
  }

  List<Widget> contentSummaryIconWidget(Character character) {
    List<Widget> summaryIcons = [];
    bool dailyNotClear = false;
    bool weeklyNotClear = false;
    bool raidNotClear = false;

    bool dailySummaryIcon = false;
    bool weeklySummaryIcon = false;
    bool raidSummaryIcon = false;

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
        raidSummaryIcon = true;
      }
      if (raidContent.isChecked) {
        for (int i = 0; i < raidContent.clearCheckStandardPhase; i++) {
          if (!raidContent.clearList[i].check) {
            raidNotClear = true;
          }
        }
      }
    });
    if (dailySummaryIcon) {
      summaryIcons.add(Container(
        margin: const EdgeInsets.only(top: 3, right: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green),
          color: Colors.green,
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
                        color: Colors.white,
                      ),
                    ),
              SizedBox(
                width: 3,
              ),
              Text(
                '일일',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13),
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
          border: Border.all(color: Colors.red),
          color: Colors.red,
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
                        color: Colors.white,
                      ),
                    ),
              SizedBox(
                width: 3,
              ),
              Text(
                '주간',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ));
    }
    if (raidSummaryIcon) {
      summaryIcons.add(Container(
        margin: const EdgeInsets.only(top: 3, right: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange),
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 1, 3, 1),
          child: Row(
            children: [
              raidNotClear
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
              SizedBox(width: 3),
              Text(
                '레이드',
                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ));
    }
    return summaryIcons;
  }

  List<Widget> restGaugeNumberWidget(BuildContext context, int characterIndex, Character character) {
    List<Widget> restGauges = [];
    for (int index = 0; index < 3; index++) {
      if (character.dailyContents[index].isChecked) {
        restGauges.add(Row(
          children: [
            Image.asset(
              'assets/daily/${index}.png',
              width: 25,
              height: 25,
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
}
