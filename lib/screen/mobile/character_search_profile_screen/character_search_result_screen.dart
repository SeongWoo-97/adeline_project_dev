import 'dart:io';
import 'dart:typed_data';
import 'package:adeline_app/model/dark_mode/android/android_dark_theme_data.dart';
import 'package:adeline_app/model/toast/toast.dart';
import 'package:adeline_app/providers/fetch_character_profile.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/avatar_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/collection_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/equip_screen.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/menu_bar.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/profile_info.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/widget/skill/skill_screen.dart';
import 'package:adeline_app/screen/mobile/custom_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:async/async.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class CharacterSearchResultScreen extends StatefulWidget {
  final nickName;

  const CharacterSearchResultScreen({Key? key, this.nickName}) : super(key: key);

  @override
  State<CharacterSearchResultScreen> createState() => _CharacterSearchResultScreenState();
}

class _CharacterSearchResultScreenState extends State<CharacterSearchResultScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  final AsyncMemoizer memoizer = AsyncMemoizer();
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    MenuBarController menuBarController = Provider.of<MenuBarController>(context, listen: false);
    ProfileController profileController = Provider.of<ProfileController>(context,listen: false);
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
          future: profileController.fetchCharacterProfile(context, widget.nickName),
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
