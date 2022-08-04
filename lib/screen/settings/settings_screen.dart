import 'package:adeline_app/main.dart';
import 'package:adeline_app/model/dark_mode/dark_theme_provider.dart';
import 'package:adeline_app/model/uri_launch/launch_url.dart';
import 'package:adeline_app/screen/main/mobile/mobile_main.dart';
import 'package:adeline_app/screen/settings/sources_screen.dart';
import 'package:adeline_app/screen/settings/update_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../model/toast/toast.dart';
import '../../../model/user/expedition/expedition_model.dart';
import '../../../model/user/user.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('설정'),
      ),
      body: SafeArea(
        child: SettingsList(
          lightTheme: SettingsThemeData(settingsListBackground: Colors.grey[50]),
          sections: [
            SettingsSection(
              margin: EdgeInsetsDirectional.all(0),
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text('1:1 채팅방으로 버그 제보하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '카카오톡으로 버그제보 및 의견을 말해주세요.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) async {
                    LaunchUrl.launchURL("https://open.kakao.com/o/sTNAkmKd");
                  },
                ),
                SettingsTile.navigation(
                  title: Text('디스코드 방 입장하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '디스코드로 개발자에게 버그제보및 의견을 말해주세요.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) async {
                    LaunchUrl.launchURL("https://discord.gg/w574G4EaAS");
                  },
                ),
                SettingsTile.navigation(
                  title: Text('캐릭터 전체 초기화', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '숙제 관리에 있는 모든 캐릭터가 사라집니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) async {
                    showPlatformDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PlatformAlertDialog(
                          content: Text(
                            '캐릭터마다 설정했던 모든 정보가 사라집니다. 초기화하시겠습니까?',
                          ),
                          actions: [
                            PlatformDialogAction(
                              child: PlatformText('취소'),
                              // 캐릭터 순서 페이지로 이동
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            PlatformDialogAction(
                              child: PlatformText('초기화'),
                              // 캐릭터 순서 페이지로 이동
                              onPressed: () {
                                final characterBox = Hive.box<User>(hiveUserName);
                                final expeditionBox = Hive.box<Expedition>(hiveExpeditionName);
                                characterBox.delete('user');
                                expeditionBox.delete('expeditionList');
                                ToastMessage.toast('캐릭터 초기화 완료!');
                                Navigator.pushAndRemoveUntil(
                                    context, MaterialPageRoute(builder: (context) => MobileMainScreen(index: 1,)), (route) => false);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                SettingsTile.navigation(
                  title: Text('앱 실행시 초기화면 설정', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '앱 실행 시 초기화면을 선택하실 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) async {
                    showPlatformDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PlatformAlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  child: Text('분배금 계산기', style: Theme.of(context).textTheme.bodyText1),
                                  onPressed: () {
                                    Hive.box('firstScreen').put('index', 0);
                                    Navigator.pop(context);

                                    ToastMessage.toast('분배금 계산기 페이지가 초기설정 페이지로 변경되었습니다.');
                                  },
                                ),
                              ),
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  child: Text('숙제 관리', style: Theme.of(context).textTheme.bodyText1),
                                  onPressed: () {
                                    Hive.box('firstScreen').put('index', 1);
                                    Navigator.pop(context);
                                    ToastMessage.toast('숙제 관리 페이지가 초기설정 페이지로 변경되었습니다.');
                                  },
                                ),
                              ),
                              Container(
                                width: 150,
                                child: ElevatedButton(
                                  child: Text('홈 화면', style: Theme.of(context).textTheme.bodyText1),
                                  onPressed: () {
                                    Hive.box('firstScreen').put('index', 2);
                                    Navigator.pop(context);
                                    ToastMessage.toast('홈 화면 페이지가 초기설정 페이지로 변경되었습니다.');
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                // SettingsTile.navigation(
                //   title: Text('캐릭터 숙제 백업하기', style: Theme.of(context).textTheme.bodyText1),
                //   value: Text(
                //     '캐릭터의 정보를 서버에 저장하여 다른 기기에서도 기존 데이터를 불러올 수 있습니다.',
                //     style: Theme.of(context).textTheme.caption,
                //   ),
                //   onPressed: (context) => ToastMessage.toast('구현되지 않은 기능입니다.'),
                // ),
                // SettingsTile.navigation(
                //   title: Text('캐릭터 숙제 불러오기', style: Theme.of(context).textTheme.bodyText1),
                //   value: Text(
                //     '서버에 저장한 데이터를 불러와서 적용 시킵니다.',
                //     style: Theme.of(context).textTheme.caption,
                //   ),
                //   onPressed: (context) => ToastMessage.toast('구현되지 않은 기능입니다.'),
                // ),
                SettingsTile.navigation(
                  title: Text('골드 콘텐츠 업데이트 하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '골드를 지급하는 새로운 콘텐츠가 본섭에 추가될 시 골드 콘텐츠 목록을 업데이트하는 기능입니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) => ToastMessage.toast('구현되지 않은 기능입니다.'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) => DarkMode.setDarkTheme(value),
                  initialValue: Hive.box('themeData').get('darkMode', defaultValue: false), // initialValue 의 반대값이 value 로 넘어감
                  leading: Icon(Icons.dark_mode),
                  title: Text('다크모드', style: Theme.of(context).textTheme.bodyText1),
                ),
                SettingsTile.navigation(
                  title: Text('업데이트 내역', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '업데이트 기록을 볼 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateListScreen())),
                ),
                SettingsTile.navigation(
                  title: Text('출처', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '앱에서 사용된 이미지와 API 출처를 적어 놓았습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => SourcesScreen())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
