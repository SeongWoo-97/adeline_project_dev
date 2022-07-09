import 'package:adeline_app/model/user/user_provider.dart';
import 'package:adeline_app/screen/mobile/character_manual_add_screen/character_manual_add_screen.dart';
import 'package:adeline_app/screen/mobile/character_reorder_screen/character_reorder_screen.dart';
import 'package:adeline_app/screen/mobile/init_date_check_screen/init_date_check_screen.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class PopupMenuWidget extends StatelessWidget {
  final CustomPopupMenuController _customPopupMenuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    return CustomPopupMenu(
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
                              children: [Text('수동 초기화를 진행하시겠습니까?\n단, 휴식콘텐츠는 초기화가 되지 않습니다.')],
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
    );
  }
}
