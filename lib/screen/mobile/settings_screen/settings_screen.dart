import 'package:adeline_project_dev/main.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/initSettings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

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
                    '앱의 모든 업데이트 내역을 볼수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SettingsTile.navigation(
                  title: Text('캐릭터 전체 초기화', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '숙제관리에 있는 모든캐릭터가 사라집니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                  onPressed: (context) {
                    final characterBox = Hive.box<User>('characters');
                    final expeditionBox = Hive.box<Expedition>('expedition');
                    characterBox.delete('user');
                    expeditionBox.delete('expeditionList');

                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => InitSettingsScreen()), (route) => false);
                  },
                ),
                SettingsTile.navigation(
                  title: Text('캐릭터 숙제 백업하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '캐릭터의 정보를 서버에 저장하여 다른 기기에서도 한번에 기존 데이터를 불러 올수있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SettingsTile.navigation(
                  title: Text('캐릭터 숙제 불러오기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '서버에 저장한 데이터를 불러와서 적용 시킵니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SettingsTile.navigation(
                  title: Text('1:1 채팅방으로 버그 제보하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '카카오톡으로 개발자에게 하고싶은 말을 할 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                SettingsTile.navigation(
                  title: Text('디스코드 방 입장하기', style: Theme.of(context).textTheme.bodyText1),
                  value: Text(
                    '디스코드로 개발자에게 하고싶은 말을 할 수 있습니다.',
                    style: Theme.of(context).textTheme.caption,
                  ),
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
}
