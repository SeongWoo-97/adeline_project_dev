import 'package:adeline_app/providers/fetch_character_profile.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/character_search_result_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/profile_info.dart';
import 'package:adeline_app/screen/mobile/custom_scroll.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:adeline_app/model/profile/character_profile.dart';
import 'package:adeline_app/model/profile/character_profile_provider.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/avatar_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/collection_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/equip_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/menu_bar.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/skill/skill_screen.dart';

class RwdCharacterProfileScreen extends StatefulWidget {
  final nickName;

  RwdCharacterProfileScreen({this.nickName});

  @override
  State<RwdCharacterProfileScreen> createState() => _RwdCharacterProfileScreenState();
}

class _RwdCharacterProfileScreenState extends State<RwdCharacterProfileScreen> {
  Future? futureFetch;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    futureFetch = Provider.of<ProfileController>(context, listen: false).fetchCharacterProfile(context, widget.nickName);
  }

  @override
  Widget build(BuildContext context) {
    MenuBarController menuBarController = Provider.of<MenuBarController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('캐릭터 정보'),
        actions: [
          TextButton(onPressed: (){
            print('width : ${MediaQuery.of(context).size.width}');
          }, child: Text('width 출력'))
        ],
      ),
      body: FutureBuilder(
        future: futureFetch,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('에러가 발생하였습니다. 개발자에게 문의 바랍니다.'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            return LayoutBuilder(
              builder: ((context, constraints) {
                // desktop, tablet
                if (constraints.maxWidth >= 800) {
                  return ScrollConfiguration(
                    behavior: CustomScroll(),
                    child: SingleChildScrollView(
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
                  );
                } else {
                  // mobile
                  return ScrollConfiguration(
                    behavior: CustomScroll(),
                    child: SingleChildScrollView(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ProfileInfoWidget(),
                        Card(
                          child: Column(
                            children: [
                              MenuBarWidget(),
                              ExpandablePageView(
                                controller: menuBarController.pageController,
                                onPageChanged: (value) => menuBarController.menuOnChanged(value),
                                children: [
                                  EquipScreen(),
                                  SkillScreen(),
                                  CollectionScreen(),
                                  AvatarScreen(),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  ),);
              }
              }),
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
