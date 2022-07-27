import 'package:adeline_app/firebase_options.dart';
import 'package:adeline_app/model/user/content/raid_content.dart';
import 'package:adeline_app/screen/character_search/controller/profile_controller.dart';
import 'package:adeline_app/screen/character_search/controller/menu_bar_controller.dart';
import 'package:adeline_app/screen/home_work/character_manual_add_screen/controller/add_character_provider.dart';
import 'package:adeline_app/screen/home_work/init_settings/controller/initSettings_controller.dart';
import 'package:adeline_app/screen/main/controller/event_notice_controller.dart';
import 'package:adeline_app/screen/main/controller/notice_controller.dart';
import 'package:adeline_app/screen/main/main_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'model/add_content_provider/add_content_provider.dart';
import 'model/add_content_provider/add_expedition_content_provider.dart';
import 'model/profile/character_profile.dart';
import 'model/profile/character_profile_provider.dart';
import 'model/user/character/character_model.dart';
import 'model/user/character/character_provider.dart';
import 'model/user/content/daily_content.dart';
import 'model/user/content/expedition_content.dart';
import 'model/user/content/restGauge_content.dart';
import 'model/user/content/weekly_content.dart';
import 'model/user/expedition/expedition_model.dart';
import 'model/user/expedition/expedition_provider.dart';
import 'model/user/user.dart';
import 'model/user/user_provider.dart';

String hiveUserName = "characters2";
String hiveExpeditionName = "expedition2";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(DailyContentAdapter());
  Hive.registerAdapter(WeeklyContentAdapter());
  Hive.registerAdapter(RaidContentAdapter());
  Hive.registerAdapter(ExpeditionAdapter());
  Hive.registerAdapter(ExpeditionContentAdapter());
  Hive.registerAdapter(RestGaugeContentAdapter());
  Hive.registerAdapter(CheckHistoryAdapter());
  await Hive.openBox('themeData');
  await Hive.openBox('expeditionIsExpand');
  await Hive.openBox('firstScreen');
  await Hive.openBox<User>(hiveUserName);
  await Hive.openBox<Expedition>(hiveExpeditionName);
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
        ChangeNotifierProvider(create: (context) => ProfileController())
      ],
      child: MainLayout(),
    ),
  );
}
