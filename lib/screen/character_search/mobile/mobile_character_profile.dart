import 'dart:io';
import 'dart:typed_data';

import 'package:adeline_app/model/dark_mode/android/android_dark_theme_data.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/screen/character_search/controller/profile_controller.dart';
import 'package:adeline_app/screen/character_search/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/character_search/widget/avatar_screen.dart';
import 'package:adeline_app/screen/character_search/widget/collection_screen.dart';
import 'package:adeline_app/screen/character_search/widget/equip_screen.dart';
import 'package:adeline_app/screen/character_search/widget/menu_bar.dart';
import 'package:adeline_app/screen/character_search/widget/profile_info.dart';
import 'package:adeline_app/screen/character_search/widget/skill/skill_screen.dart';
import 'package:adeline_app/screen/custom_scroll.dart';
import 'package:async/async.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MobileCharacterProfileScreen extends StatefulWidget {
  final nickName;

  MobileCharacterProfileScreen({this.nickName});

  @override
  State<MobileCharacterProfileScreen> createState() => _MobileCharacterProfileScreenState();
}

class _MobileCharacterProfileScreenState extends State<MobileCharacterProfileScreen> {
  final ScreenshotController screenshotController = ScreenshotController();

  final AsyncMemoizer memoizer = AsyncMemoizer();

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    MenuBarController menuBarController = Provider.of<MenuBarController>(context, listen: false);
    return Theme(
      data: androidDarkThemeData,
      child: PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('캐릭터 정보'),
          trailingActions: [
            IconButton(
                onPressed: () async {
                  await screenshotController.capture(delay: const Duration(milliseconds: 10)).then(
                    (Uint8List? image) async {
                      if (image != null) {
                        await ImageGallerySaver.saveImage(Uint8List.fromList(image),
                            quality: 100, name: "${widget.nickName}_${DateTime.now()}");
                        ToastMessage.toast('스크린샷이 갤러리에 저장되었습니다.');
                      }
                    },
                  );
                },
                icon: Icon(Icons.camera_alt_outlined))
          ],
        ),
        material: (_, __) => MaterialScaffoldData(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.share_outlined),
            onPressed: () async {
              await screenshotController.capture(delay: const Duration(milliseconds: 10)).then(
                (Uint8List? image) async {
                  if (image != null) {
                    final directory = await getApplicationDocumentsDirectory();
                    final imagePath = await File('${directory.path}/image2.png').create();
                    await imagePath.writeAsBytes(image);
                    await ImageGallerySaver.saveImage(Uint8List.fromList(image),
                        quality: 100, name: "${widget.nickName}_${DateTime.now()}");

                    /// Share Plugin
                    await Share.shareFiles([imagePath.path]);
                  }
                },
              );
            },
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<ProfileController>(context,listen: false).futureFetch,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('에러가 발생하였습니다. 개발자에게 문의 바랍니다.'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data != null) {
              return ScrollConfiguration(
                behavior: CustomScroll(),
                child: SingleChildScrollView(
                  child: Screenshot(
                    controller: screenshotController,
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
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
