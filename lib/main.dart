import 'package:adeline_app/model/dark_mode/android/android_light_theme_data.dart';
import 'package:adeline_app/screen/mobile/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:adeline_app/screen/mobile/character_manual_add_screen/controller/add_character_provider.dart';
import 'package:adeline_app/screen/mobile/character_search_profile_screen/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/mobile/characters_slot_screen/init_screen/controller/initSettings_controller.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_controller/event_notice_controller.dart';
import 'package:adeline_app/screen/mobile/home_screen/widget/lostark_notice_controller/notice_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'model/add_content_provider/add_content_provider.dart';
import 'model/add_content_provider/add_expedition_content_provider.dart';
import 'model/dark_mode/android/android_dark_theme_data.dart';
import 'model/dark_mode/dark_theme_provider.dart';
import 'model/profile/character_profile.dart';
import 'model/profile/character_profile_provider.dart';
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
  await Hive.openBox('themeData');
  await Hive.openBox<User>('characters');
  await Hive.openBox<Expedition>('expedition');
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
        ChangeNotifierProvider(create: (context) => CharacterProfileProvider(profile: CharacterProfile())),
        ChangeNotifierProvider(create: (context) => MenuBarController()),
        ChangeNotifierProvider(create: (context) => CollectionMenuBarController()),
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
          home: BottomNavigationScreen(),
        );
      },
    );
  }
}