import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/user/character/character_model.dart';
import 'package:adeline_app/model/user/content/daily_content.dart';
import 'package:adeline_app/model/user/content/expedition_content.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:adeline_app/model/user/content/restGauge_content.dart';
import 'package:adeline_app/model/user/expedition/expedition_model.dart';
import 'package:adeline_app/model/user/expedition/expedition_provider.dart';
import 'package:adeline_app/model/user/user.dart';
import 'package:adeline_app/model/user/user_provider.dart';
import 'package:adeline_app/screen/home_work/characters_slot/mobile/mobile_characters_slot.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/not_mobile_character_slot.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CharacterSlotLayout extends StatefulWidget {
  const CharacterSlotLayout({Key? key}) : super(key: key);

  @override
  State<CharacterSlotLayout> createState() => _CharacterSlotLayoutState();
}

class _CharacterSlotLayoutState extends State<CharacterSlotLayout> {
  List<Character> characterList = [];
  List<ExpeditionContent> expeditionList = [];
  late Expedition expedition;
  DateTime nowDate = DateTime.now();
  DateTime? init6AmTime;

  // 현재는 오전 6시 이후에만 초기화가 진행됨
  // DateTime nowDate = DateTime.utc(2022, 7, 15, 7, Random().nextInt(59), Random().nextInt(59));
  // DateTime init6AmTime = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6);
  @override
  void initState() {
    super.initState();
    characterList = Hive.box<User>(hiveUserName).get('user')!.characters;
    expeditionList = Hive.box<Expedition>(hiveExpeditionName).get('expeditionList')!.list;
    expedition = Hive.box<Expedition>(hiveExpeditionName).get('expeditionList')!;
    init6AmTime = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);

    if (nowDate.hour < 6) {
      nowDate = nowDate;
    } else {
      // nowDate(현재시간)이 6시 이후 일 때
      nowDate = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 7);
    }

    // 휴식게이지 로직
    characterList.forEach(
      (character) {
        character.dailyContents.forEach(
          (dailyContent) {
            if (dailyContent is RestGaugeContent) {
              DateTime lateRevision =
                  DateTime.utc(dailyContent.lateRevision.year, dailyContent.lateRevision.month, dailyContent.lateRevision.day, 6);
              int clearNum = dailyContent.clearNum;
              int maxClearNum = dailyContent.maxClearNum;
              dailyContent.saveLateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);

              if (nowDate.hour >= 6 && (nowDate.day == dailyContent.lateRevision.day) && (dailyContent.lateRevision.hour < 6)) {
                dailyContent.restGauge += (maxClearNum - clearNum) * 10;
                dailyContent.clearNum = 0;
                dailyContent.saveRestGauge = 0;
                dailyContent.lateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
              } else if (nowDate.difference(lateRevision).inDays == 1) {
                dailyContent.restGauge += (maxClearNum - clearNum) * 10;
                dailyContent.clearNum = 0;
                dailyContent.saveRestGauge = 0;
                dailyContent.lateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
              } else if (nowDate.difference(lateRevision).inDays > 1) {
                int diffDate = DateTime.utc(nowDate.year, nowDate.month, nowDate.day)
                    .difference(DateTime.utc(lateRevision.year, lateRevision.month, lateRevision.day + 1))
                    .inDays;
                dailyContent.restGauge = ((maxClearNum - clearNum) * 10) + (diffDate * maxClearNum * 10);
                dailyContent.clearNum = 0;
                dailyContent.saveRestGauge = 0;
                dailyContent.lateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
              }

              if (dailyContent.restGauge >= 100) {
                dailyContent.restGauge = 100;
                dailyContent.lateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
              }
            }
          },
        );
      },
    );
    // 휴식게이지 로직

    // 일일 초기화 로직
    if (expedition.recentInitDateTime.isBefore(init6AmTime!) && nowDate.isAfter(init6AmTime!)) {
      expedition.recentInitDateTime = nowDate;
      expedition.list.forEach(
        (expeditionContent) {
          if (expeditionContent.type == "일일") {
            expeditionContent.clearCheck = false;
          }
        },
      );
      characterList.forEach((character) {
        character.dailyContents.forEach((dailyContent) {
          if (dailyContent is DailyContent) {
            dailyContent.clearChecked = false;
          }
        });
      });
    } else if (nowDate.difference(expedition.recentInitDateTime).inDays == 1 && nowDate.hour >= 6) {
      expedition.recentInitDateTime = nowDate;
      expedition.list.forEach(
        (expeditionContent) {
          if (expeditionContent.type == "일일") {
            expeditionContent.clearCheck = false;
          }
        },
      );
      characterList.forEach((character) {
        character.dailyContents.forEach((dailyContent) {
          if (dailyContent is DailyContent) {
            dailyContent.clearChecked = false;
          }
        });
      });
    } else if (nowDate.difference(expedition.recentInitDateTime).inDays > 1) {
      expedition.recentInitDateTime = nowDate;
      expedition.list.forEach(
        (expeditionContent) {
          if (expeditionContent.type == "일일") {
            expeditionContent.clearCheck = false;
          }
        },
      );
      characterList.forEach((character) {
        character.dailyContents.forEach((dailyContent) {
          if (dailyContent is DailyContent) {
            dailyContent.clearChecked = false;
          }
        });
      });
    }

    // 캐릭터,원정대 주간 초기화 로직
    if ((expedition.nextWednesday.isBefore(nowDate) && (nowDate.hour >= 6 || nowDate.weekday != 3))) {
      if (expedition.nextWednesday.weekday == 3) {
        expedition.nextWednesday = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6).add(Duration(days: 7));
      } else {
        while (expedition.nextWednesday.weekday != 3) {
          expedition.nextWednesday = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6).add(Duration(days: 1));
        }
      }
      // 원정대 주간 초기화 로직
      expedition.list.forEach(
        (expeditionContent) {
          if (expeditionContent.type == "주간") {
            expeditionContent.clearCheck = false;
          }
        },
      );
      // 주간,레이드 콘텐츠 초기화 로직
      characterList.forEach((character) {
        character.weeklyContents.forEach((weeklyContent) {
          weeklyContent.clearChecked = false;
        });
        character.raidContents.forEach((raidContent) {
          raidContent.clearList =
              List.generate(raidContent.totalPhase, (index) => CheckHistory(difficulty: raidContent.difficulty.first, check: false));
          raidContent.bonusList =
              List.generate(raidContent.totalPhase, (index) => CheckHistory(difficulty: raidContent.difficulty.first, check: false));
          raidContent.addGold = 0;
        });
      });
    }

    Hive.box<User>(hiveUserName).put('user', User(characters: characterList));
    Hive.box<Expedition>(hiveExpeditionName).put('expeditionList', expedition);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context,listen: false);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    expeditionProvider.expedition = expedition;
    userProvider.charactersProvider.characters = characterList;
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 800) {
        return NotMobileCharacterSlotScreen();
      } else {
        return MobileCharactersSlotScreen();
      }
    });
  }
}
