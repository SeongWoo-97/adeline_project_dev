import 'package:adeline_app/model/user/user_provider.dart';
import 'package:adeline_app/screen/home_work/character_manual_add_screen/character_manual_add_screen.dart';
import 'package:adeline_app/screen/home_work/character_reorder_screen/character_reorder_screen.dart';
import 'package:adeline_app/screen/home_work/characters_slot/widget/character_slot_list.dart';
import 'package:adeline_app/screen/home_work/characters_slot/widget/content_board.dart';
import 'package:adeline_app/screen/home_work/characters_slot/widget/expedition_contents.dart';
import 'package:adeline_app/screen/home_work/characters_slot/widget/total_gold.dart';
import 'package:adeline_app/screen/home_work/init_date_check/init_date_check_screen.dart';
import 'package:adeline_app/screen/main/mobile/mobile_main.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MobileCharactersSlotScreen extends StatefulWidget {
  const MobileCharactersSlotScreen({Key? key}) : super(key: key);

  @override
  State<MobileCharactersSlotScreen> createState() => _MobileCharactersSlotScreenState();
}

class _MobileCharactersSlotScreenState extends State<MobileCharactersSlotScreen> with AutomaticKeepAliveClientMixin {
  CustomPopupMenuController _customPopupMenuController = CustomPopupMenuController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
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
                      builder: (context) => MobileMainScreen(
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
