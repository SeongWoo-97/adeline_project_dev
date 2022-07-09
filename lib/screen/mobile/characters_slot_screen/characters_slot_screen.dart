import 'package:adeline_app/screen/mobile/characters_slot_screen/widget/content_board.dart';
import 'package:adeline_app/screen/mobile/characters_slot_screen/widget/pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../model/user/character/character_model.dart';
import '../../../model/user/content/daily_content.dart';
import '../../../model/user/content/expedition_content.dart';
import '../../../model/user/content/restGauge_content.dart';
import '../../../model/user/expedition/expedition_model.dart';
import '../../../model/user/expedition/expedition_provider.dart';
import '../../../model/user/user.dart';
import '../../../model/user/user_provider.dart';
import '../bottom_navigation_screen/bottom_navigation_screen.dart';
import '../characters_slot_screen/widget/character_slot_list.dart';
import '../characters_slot_screen/widget/expedition_contents.dart';
import '../characters_slot_screen/widget/total_gold.dart';

class CharactersSlotScreen extends StatefulWidget {
  const CharactersSlotScreen({Key? key}) : super(key: key);

  @override
  State<CharactersSlotScreen> createState() => _CharactersSlotScreenState();
}

class _CharactersSlotScreenState extends State<CharactersSlotScreen> with AutomaticKeepAliveClientMixin {
  List<Character> characterList = [];
  List<ExpeditionContent> expeditionList = [];
  late Expedition expedition;

  // DateTime nowDate = DateTime.utc(2022, 5, 25, 10);
  DateTime nowDate = DateTime.now();
  DateTime init6AmTime = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6);

  @override
  void initState() {
    super.initState();
    characterList = Hive.box<User>('characters').get('user')!.characters;
    expeditionList = Hive.box<Expedition>('expedition').get('expeditionList')!.list;
    expedition = Hive.box<Expedition>('expedition').get('expeditionList')!;

    /// 원래 코드
    //
    if (DateTime.now().hour < 6) {
      nowDate = DateTime.now();
    } else {
      nowDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6);
    }

    /// 테스트 코드

    // if (nowDate.hour < 6) {
    //   nowDate = nowDate;
    // } else {
    //   nowDate = DateTime.utc(nowDate.year, nowDate.month, nowDate.day, 6);
    // }

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

    // print('nowDate.isAfter(init6AmTime) : ${nowDate.isAfter(init6AmTime)}');
    if (expedition.recentInitDateTime.isAfter(init6AmTime) == false && nowDate.isAfter(init6AmTime) == false) {
      expedition.recentInitDateTime = DateTime.now().toUtc().add(Duration(hours: 9));
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
            expeditionContent.clearCheck = false;
          }
        },
      );
      characterList.forEach((character) {
        character.weeklyContents.forEach((weeklyContent) {
          weeklyContent.clearChecked = false;
        });
        character.raidContents.forEach((raidContents) {
          raidContents.clearChecked = false;
          raidContents.clearGold = 0;
          raidContents.addGold = 0;
        });
      });
    }
    Hive.box<User>('characters').put('user', User(characters: characterList));
    Hive.box<Expedition>('expedition').put('expeditionList', expedition);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context, listen: false);
    expeditionProvider.expedition = expedition;
    userProvider.charactersProvider.characters = characterList;
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('숙제 관리'),
        trailingActions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "새로고침이 완료 되었습니다.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.grey,
                  timeInSecForIosWeb: 2,
                  fontSize: 14.0);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BottomNavigationScreen(
                            index: 1,
                          )));
            },
            icon: Icon(Icons.refresh_outlined),
          ),
          PopupMenuWidget(),
        ],
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
