import 'package:adeline_app/screen/mobile/characters_slot_screen/widget/content_board_widget.dart';
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
import '../character_manual_add_screen/character_manual_add_screen.dart';
import '../character_reorder_screen/character_reorder_screen.dart';
import '../characters_slot_screen/widget/character_slot_widget.dart';
import '../characters_slot_screen/widget/expedition_content_widget.dart';
import '../characters_slot_screen/widget/total_gold_widget.dart';
import '../drawer_screen/drawer_screen.dart';
import '../init_date_check_screen/init_date_check_screen.dart';

class CharactersSlotScreen extends StatefulWidget {
  const CharactersSlotScreen({Key? key}) : super(key: key);

  @override
  State<CharactersSlotScreen> createState() => _CharactersSlotScreenState();
}

class _CharactersSlotScreenState extends State<CharactersSlotScreen> with AutomaticKeepAliveClientMixin {
  CustomPopupMenuController _customPopupMenuController = CustomPopupMenuController();
  List<Character> characterList = [];
  List<ExpeditionContent> expeditionList = [];
  late Expedition expedition;

  // DateTime nowDate = DateTime.utc(2022, 5, 25, 10);
  DateTime nowDate = DateTime.now();

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
            // print('원정대 주간초기화 : ${expeditionContent.name} , ${expeditionContent.clearCheck}');
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
          goldContent.addGold = 0;
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
    ExpeditionProvider expeditionProvider = Provider.of<ExpeditionProvider>(context,listen: false);
    userProvider.updateContentBoard();
    userProvider.updateTotalGold();
    expeditionProvider.expedition = expedition;
    userProvider.charactersProvider.characters = characterList;
    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(
        drawer: Container(width: 230, child: DrawerScreen()),
      ),
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
              },
              icon: Icon(Icons.refresh_outlined)),
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
                                    '관문 선택 방법',
                                    style: TextStyle(fontSize: 15, color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () async {
                          _customPopupMenuController.hideMenu();
                          Fluttertoast.showToast(
                              msg: "캐릭터의 골드 버튼을 누른 후 콘텐츠의 이름을 1초간 눌러주시면 해제됩니다.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.grey,
                              timeInSecForIosWeb: 2,
                              fontSize: 14.0);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
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
