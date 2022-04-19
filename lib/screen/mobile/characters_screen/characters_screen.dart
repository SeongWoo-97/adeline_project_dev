import 'package:adeline_project_dev/model/user/content/daily_content.dart';
import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
import 'package:adeline_project_dev/model/user/content/restGauge_content.dart';
import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/character_slot_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/content_board_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/expedition_content_widget.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/widget/total_gold_widget.dart';
import 'package:adeline_project_dev/screen/mobile/drawer_screen/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../model/user/character/character_model.dart';
import '../../../model/user/expedition/expedition_model.dart';
import '../../../model/user/expedition/expedition_provider.dart';
import '../../../model/user/user.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> with AutomaticKeepAliveClientMixin {
  List<Character> characterList = [];
  List<ExpeditionContent> expeditionList = [];
  late Expedition expedition;
  DateTime nowDate = DateTime.utc(2022, 4, 20, 7);
  // late DateTime nowDate;
  @override
  void initState() {
    super.initState();
    characterList = Hive.box<User>('characters').get('user')!.characters;
    expeditionList = Hive.box<Expedition>('expedition').get('expeditionList')!.list;
    expedition = Hive.box<Expedition>('expedition').get('expeditionList')!;
    /// 원래 코드

    // if (DateTime.now().hour < 6) {
    //   nowDate = DateTime.now();
    // } else {
    //   nowDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6);
    // }

    /// 테스트 코드

    if (nowDate.hour < 6) {
        nowDate = nowDate;
      } else {
        nowDate = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
      }

    print('초기화 전(expedition.nextWednesday) : ${expedition.nextWednesday}');
    print('초기화 전(expedition.recentInitDateTime) : ${expedition.recentInitDateTime}');
    print('초기화 전(characterList[0].dailyContents[0].lateRevision) : ${characterList[0].dailyContents[0].lateRevision}');
    // 휴식게이지 로직
    characterList.forEach(
      (character) {
        character.dailyContents.forEach(
          (dailyContent) {
            if (dailyContent is RestGaugeContent) {
              DateTime lateRevision = DateTime.utc(dailyContent.lateRevision.year, dailyContent.lateRevision.month, dailyContent.lateRevision.day, 6);
              int clearNum = dailyContent.clearNum;
              int maxClearNum = dailyContent.maxClearNum;
              dailyContent.saveLateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);

              if (dailyContent.lateRevision.day != nowDate.day && nowDate.hour >= 6) {
                if (nowDate.difference(lateRevision).inDays == 1) {
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

                  if (dailyContent.restGauge >= 100) {
                    dailyContent.restGauge = 100;
                  }
                }
                if (dailyContent.restGauge >= 100) {
                  dailyContent.restGauge = 100;
                  dailyContent.lateRevision = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
                }
              }
            }
            // 일반 일일콘텐츠 초기화 로직
            if (dailyContent is DailyContent && dailyContent.recentInitDateTime.day != nowDate.day && nowDate.hour >= 6) {
              dailyContent.recentInitDateTime = nowDate;
              dailyContent.clearChecked = false;
            }
          },
        );
      },
    ); // 휴식게이지 로직
    // 원정대 일일 콘텐츠 초기화 로직
    if (expedition.recentInitDateTime.day != nowDate.day && nowDate.hour >= 6) {
      expedition.recentInitDateTime = nowDate;
      expedition.list.forEach(
        (expeditionContent) {
          if (expeditionContent.type == "일일") {
            expeditionContent.clearCheck = false;
          }
        },
      );
    }

    // 캐릭터,원정대 주간,골드 초기화 로직
    if (nowDate == expedition.nextWednesday && nowDate.hour >= 6) {
      if (expedition.nextWednesday.weekday == 3) {
        expedition.nextWednesday = nowDate.add(Duration(days: 7));
      } else {
        while (expedition.nextWednesday.weekday != 3) {
          expedition.nextWednesday = nowDate.add(Duration(days: 1));
        }
      }
      expedition.list.forEach(
        (expeditionContent) {
          if (expeditionContent.type == "주간") {
            print('원정대 주간초기화 : ${expeditionContent.name} , ${expeditionContent.clearCheck}');
            expeditionContent.clearCheck = false;
          }
        },
      );
      characterList.forEach((character) {
        character.weeklyContents.forEach((weeklyContent) {
          weeklyContent.clearChecked = false;
        });
        character.goldContents.forEach((goldContent) {
          goldContent.clearChecked = false;
          goldContent.clearGold = 0;
        });
      });
    }
    // 일반 일일 콘텐츠, 원정대 일일 콘텐츠 초기화
    // 일반 주간 콘텐츠, 원정대 주간 콘텐츠, 골드 콘텐츠 초기화
    print('초기화 후(expedition.nextWednesday) : ${expedition.nextWednesday}');
    print('초기화 후(expedition.recentInitDateTime) : ${expedition.recentInitDateTime}');
    print('초기화 후(characterList[0].dailyContents[0].lateRevision) : ${characterList[0].dailyContents[0].lateRevision}');
    Hive.box<User>('characters').put('user', User(characters: characterList));
    Hive.box<Expedition>('expedition').put('expeditionList', expedition);
  }
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context);
    expeditionProvider.expedition = expedition;
    userProvider.charactersProvider.characters = characterList;
    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(),
      appBar: PlatformAppBar(
        title: Text('숙제 관리'),
        material: (_, __) => MaterialAppBarData(),
        cupertino: (_, __) => CupertinoNavigationBarData(),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ContentBoardWidget(),
          TotalGoldWidget(),
          ExpeditionContentWidget(),
          CharacterSlotWidget(),
        ],
      ),
    );
  }
}
