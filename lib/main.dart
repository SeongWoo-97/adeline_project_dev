import 'package:adeline_app/model/dark_mode/android/android_light_theme_data.dart';
import 'package:adeline_app/screen/mobile/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:adeline_app/screen/mobile/character_manual_add_screen/controller/add_character_provider.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_controller/event_notice_controller.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_controller/notice_controller.dart';
import 'package:adeline_app/screen/mobile/init_screen/controller/initSettings_controller.dart';
import 'package:adeline_app/screen/mobile/init_screen/initSettings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'model/add_content_provider/add_content_provider.dart';
import 'model/add_content_provider/add_expedition_content_provider.dart';
import 'model/dark_mode/android/android_dark_theme_data.dart';
import 'model/dark_mode/dark_theme_provider.dart';
import 'model/user/character/character_model.dart';
import 'model/user/character/character_provider.dart';
import 'model/user/content/daily_content.dart';
import 'model/user/content/expedition_content.dart';
import 'model/user/content/gold_content.dart';
import 'model/user/content/restGauge_content.dart';
import 'model/user/content/weekly_content.dart';
import 'model/user/expedition/expedition_model.dart';
import 'model/user/expedition/expedition_provider.dart';
import 'model/user/user.dart';
import 'model/user/user_provider.dart';

bool userDB = false;
bool expeditionDB = false;
// 경로 : Directory: '/data/user/0/com.example.adeline_project_dev/app_flutter'

int a = 0;
int b = 0;
int c = 0;
int d = 0;
int e = 0;
int f = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(DailyContentAdapter());
  Hive.registerAdapter(WeeklyContentAdapter());
  Hive.registerAdapter(GoldContentAdapter());
  Hive.registerAdapter(ExpeditionAdapter());
  Hive.registerAdapter(ExpeditionContentAdapter());
  Hive.registerAdapter(RestGaugeContentAdapter());
  await Hive.openBox<User>('characters');
  await Hive.openBox<Expedition>('expedition');
  await Hive.openBox('themeData');
  // 참 : 메인화면 , 거짓 : 초기설정
  Hive.box<User>('characters').get('user') != null ? userDB = true : userDB = false;
  Hive.box<Expedition>('expedition').get('expeditionList') != null ? expeditionDB = true : expeditionDB = false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InitSettingsController()),
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider(charactersProvider: CharacterProvider())),
        ChangeNotifierProvider(create: (context) => ExpeditionProvider()),
        ChangeNotifierProvider(create: (context) => AddContentProvider()),
        ChangeNotifierProvider(create: (context) => AddExpeditionContentProvider()),
        ChangeNotifierProvider(create: (context) => AddCharacterProvider()),
        ChangeNotifierProvider(create: (context) => NoticeProvider()),
        ChangeNotifierProvider(create: (context) => EventNoticeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DarkMode.isDarkMode,
      builder: (context, box, widget) {
        return PlatformApp(
          material: (_, __) => MaterialAppData(
            builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: child!),
            themeMode: DarkMode.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
            theme: androidLightThemeData,
            darkTheme: androidDarkThemeData,
          ),
          cupertino: (_, __) => CupertinoAppData(),
          home: userDB && expeditionDB ? BottomNavigationScreen() : InitSettingsScreen(),
        );
      },
    );
  }
}