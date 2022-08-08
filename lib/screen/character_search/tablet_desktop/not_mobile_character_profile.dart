import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:adeline_app/screen/character_search/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/character_search/controller/profile_controller.dart';
import 'package:adeline_app/screen/kakao_adfit/char_search_kakao_adfit.dart';
import 'package:adeline_app/screen/character_search/widget/avatar_screen.dart';
import 'package:adeline_app/screen/character_search/widget/collection_screen.dart';
import 'package:adeline_app/screen/character_search/widget/equip_screen.dart';
import 'package:adeline_app/screen/character_search/widget/menu_bar.dart';
import 'package:adeline_app/screen/character_search/widget/profile_info.dart';
import 'package:adeline_app/screen/character_search/widget/skill/skill_screen.dart';
import 'package:adeline_app/screen/custom_scroll.dart';
import 'package:adeline_app/screen/kakao_adfit/kakao_adfit.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class NotMobileCharacterProfileScreen extends StatefulWidget {
  final nickName;

  NotMobileCharacterProfileScreen({this.nickName});

  @override
  State<NotMobileCharacterProfileScreen> createState() => _NotMobileCharacterProfileScreenState();
}

class _NotMobileCharacterProfileScreenState extends State<NotMobileCharacterProfileScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    MenuBarController menuBarController = Provider.of<MenuBarController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('캐릭터 정보'),actions: [
        IconButton(
            onPressed: () async {
              screenshotController.capture(pixelRatio: 1.5).then((Uint8List? value) {
                final _base64 = base64Encode(value!);
                final anchor =
                AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
                  ..download = "${widget.nickName}.png"
                  ..target = 'blank';

                document.body!.append(anchor);
                anchor.click();
                anchor.remove();
              });
            },
            icon: Icon(Icons.camera_alt_outlined))
      ],),
      body: FutureBuilder(
        future: Provider.of<ProfileController>(context, listen: false).futureFetch,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('에러가 발생하였습니다. 개발자에게 문의 바랍니다.'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return ScrollConfiguration(
              behavior: CustomScroll(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(child: CharSearchKakaoAdfit()),
                    Screenshot(
                      controller: screenshotController,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: ProfileInfoWidget(),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Card(
                              child: Column(
                                children: [
                                  MenuBarWidget(),
                                  ExpandablePageView(
                                    controller: menuBarController.pageController,
                                    onPageChanged: (value) => menuBarController.menuOnChanged(value),
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Flexible(child: EquipScreen()),
                                          Flexible(child: SkillScreen()),
                                        ],
                                      ),
                                      CollectionScreen(),
                                      AvatarScreen(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
