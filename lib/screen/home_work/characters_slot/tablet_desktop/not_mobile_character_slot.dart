import 'package:adeline_app/model/user/user_provider.dart';
import 'package:adeline_app/screen/home_work/character_manual_add_screen/character_manual_add_layout.dart';
import 'package:adeline_app/screen/home_work/character_reorder_screen/character_reorder_layout.dart';
import 'package:adeline_app/screen/home_work/characters_slot/character_slot_layout.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/not_mobile_character_slot_list.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/not_mobile_content_board.dart';
import 'package:adeline_app/screen/home_work/characters_slot/tablet_desktop/widget/not_mobile_expedition_content.dart';
import 'package:adeline_app/screen/home_work/characters_slot/widget/total_gold.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import '../../character_gold_limit_list/character_gold_limit_list_screen.dart';

class NotMobileCharacterSlotScreen extends StatelessWidget {
  final CustomPopupMenuController _customPopupMenuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '숙제 관리 ${MediaQuery.of(context).size.width},${MediaQuery.of(context).size.height}',
        ),
        actions: [
          CustomPopupMenu(
            controller: _customPopupMenuController,
            pressType: PressType.singleClick,
            verticalMargin: -10,
            horizontalMargin: 0,
            child: Container(
              child: Icon(
                Icons.more_vert_outlined,
                color: Colors.white,
              ),
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
                        child: Container(
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '수동 초기화',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
                                      onPressed: () {
                                        userProvider.manualReset(context);
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterSlotLayout()));
                                      },
                                    ),
                                    PlatformDialogAction(
                                      child: Text('아니요'),
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () async {
                          _customPopupMenuController.hideMenu();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterManualAddLayout()));
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
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black),
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
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _customPopupMenuController.hideMenu();
                          userProvider.selectedIndex = 0;
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterReOrderLayout()));
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
                                    '골드 획득 캐릭터 지정',
                                    style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          _customPopupMenuController.hideMenu();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CharacterGoldLimitListScreen()));
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
          NotMobileContentBoardWidget(),
          Padding(padding: const EdgeInsets.only(left: 5), child: TotalGoldWidget()),
          NotMobileExpeditionContentWidget(),
          NotMobileCharacterSlotListWidget(),
        ],
      ),
    );
  }
}
