import 'dart:math';

import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:adeline_app/screen/mobile/character_manual_add_screen/character_manual_add_screen.dart';
import 'package:adeline_app/screen/mobile/character_reorder_screen/character_reorder_screen.dart';
import 'package:adeline_app/screen/mobile/characters_slot_screen/widget/content_board.dart';
import 'package:adeline_app/screen/mobile/characters_slot_screen/widget/pop_up_menu.dart';
import 'package:adeline_app/screen/mobile/init_date_check_screen/init_date_check_screen.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
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
  CustomPopupMenuController _customPopupMenuController = CustomPopupMenuController();

  // 현재는 오전 6시 이후에만 초기화가 진행됨
  // DateTime nowDate = DateTime.utc(2022, 7, 15, 7, Random().nextInt(59), Random().nextInt(59));
  DateTime nowDate = DateTime.now();
  DateTime? init6AmTime;

  // DateTime init6AmTime = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 6);

  @override
  void initState() {
    super.initState();
    characterList = Hive.box<User>('characters2').get('user')!.characters;
    expeditionList = Hive.box<Expedition>('expedition2').get('expeditionList')!.list;
    expedition = Hive.box<Expedition>('expedition2').get('expeditionList')!;
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
    Hive.box<User>('characters2').put('user', User(characters: characterList));
    Hive.box<Expedition>('expedition2').put('expeditionList', expedition);
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
          CustomPopupMenu(
            controller: _customPopupMenuController,
            pressType: PressType.singleClick,
            verticalMargin: -10,
            horizontalMargin: 0,
            child: Container(
              child: Icon(Icons.more_vert_outlined),
              padding: EdgeInsets.only(right: 10),
            ),
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                color: Colors.white,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          _customPopupMenuController.hideMenu();
                          showPlatformDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('안내'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [Text('수동 초기화를 진행하시겠습니까?\n단, 휴식 콘텐츠는 클리어 횟수와 휴식 게이지가 0으로 초기화됩니다.')],
                                  ),
                                  actions: [
                                    PlatformDialogAction(
                                      child: Text('네'),
                                      onPressed: () => userProvider.manualReset(context),
                                    ),
                                    PlatformDialogAction(
                                      child: Text('아니요'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '수동 초기화',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          _customPopupMenuController.hideMenu();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterManualAddScreen()));
                        },
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '캐릭터 수동 추가',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '캐릭터 순서 및 삭제',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () async {
                          _customPopupMenuController.hideMenu();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterReOrderScreen()));
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '초기화 날짜 확인',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          _customPopupMenuController.hideMenu();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InitDateCheckScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
