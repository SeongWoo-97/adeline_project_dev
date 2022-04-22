import 'package:adeline_project_dev/main.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/initSettings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/dark_mode/darkThemePreference.dart';
import '../../../model/dark_mode/dark_theme_provider.dart';
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
    final themeChange = Provider.of<ThemeProvider>(context);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('설정'),
      ),
      body: SafeArea(
        child: SettingsList(
          lightTheme: SettingsThemeData(settingsListBackground: Colors.grey[50]),
          sections: [
            SettingsSection(
              tiles: <SettingsTile>[
                SettingsTile.navigation(
                  title: Text('업데이트 내역', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '업데이트 기록을 볼 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SettingsTile.navigation(
                  title: Text('1:1 채팅방으로 버그 제보하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '카카오톡으로 버그제보 및 문의하실 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) async {
                    _launchURL("https://open.kakao.com/o/sTNAkmKd");
                  },
                ),
                SettingsTile.navigation(
                  title: Text('디스코드 방 입장하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '디스코드로 개발자에게 하고싶은 말을 할 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) async {
                    _launchURL("https://discord.gg/w574G4EaAS");
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
                                final characterBox = Hive.box<User>('characters');
                                final expeditionBox = Hive.box<Expedition>('expedition');
                                characterBox.delete('user');
                                expeditionBox.delete('expeditionList');

                                Navigator.pushAndRemoveUntil(
                                    context, MaterialPageRoute(builder: (context) => InitSettingsScreen()), (route) => false);
                              },
                            ),
                          ],
                        );
                      },
                    );

                  },
                ),
                SettingsTile.navigation(
                  title: Text('캐릭터 숙제 백업하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '캐릭터의 정보를 서버에 저장하여 다른 기기에서도 기존 데이터를 불러올 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) => toast('구현되지 않은 기능입니다.'),
                ),
                SettingsTile.navigation(
                  title: Text('캐릭터 숙제 불러오기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '서버에 저장한 데이터를 불러와서 적용 시킵니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) => toast('구현되지 않은 기능입니다.'),
                ),
                SettingsTile.switchTile(
                  onToggle: (value) {
                    if (themeChange.darkTheme == false) {
                      setState(() {
                        themeChange.darkTheme = true;
                      });
                    } else {
                      setState(() {
                        themeChange.darkTheme = false;
                      });
                    }
                    print('themeChange.darkTheme : ${themeChange.darkTheme}');
                  },
                  initialValue: themeChange.darkTheme, // initialValue 의 반대값이 value 로 넘어감
                  leading: Icon(Icons.dark_mode),
                  title: Text('다크모드', style: Theme.of(context).textTheme.bodyText1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    } else {
      toast('알 수 없는 오류로 브라우저가 실행되지 않습니다.');
    }
  }

  void toast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16,
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
    );
  }
}
