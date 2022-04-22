import 'package:adeline_project_dev/constant/cupertino/cupertino_text_theme.dart';
import 'package:adeline_project_dev/model/add_content_provider/add_content_provider.dart';
import 'package:adeline_project_dev/model/add_content_provider/add_expedition_content_provider.dart';
import 'package:adeline_project_dev/model/dark_mode/darkThemePreference.dart';
import 'package:adeline_project_dev/model/user/character/character_model.dart';
import 'package:adeline_project_dev/model/user/content/daily_content.dart';
import 'package:adeline_project_dev/model/user/content/expedition_content.dart';
import 'package:adeline_project_dev/model/user/content/restGauge_content.dart';
import 'package:adeline_project_dev/model/user/content/weekly_content.dart';
import 'package:adeline_project_dev/model/user/expedition/expedition_model.dart';
import 'package:adeline_project_dev/model/user/user.dart';
import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:adeline_project_dev/screen/mobile/bottom_navigation_screen/bottom_navigation_screen.dart';
import 'package:adeline_project_dev/screen/mobile/character_manual_add_screen/controller/add_character_provider.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/controller/initSettings_controller.dart';

import 'package:adeline_project_dev/model/user/character/character_provider.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/initSettings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'constant/material/material_text_theme.dart';
import 'model/dark_mode/dark_theme_provider.dart';
import 'model/dark_mode/style.dart';
import 'model/user/content/gold_content.dart';
import 'model/user/expedition/expedition_provider.dart';

bool userDB = false;
bool expeditionDB = false;
bool darkMode = false;
// 경로 : Directory: '/data/user/0/com.example.adeline_project_dev/app_flutter'
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
  // 참 : 메인화면 , 거짓 : 초기설정
  Hive.box<User>('characters').get('user') != null ? userDB = true : userDB = false;
  Hive.box<Expedition>('expedition').get('expeditionList') != null ? expeditionDB = true : expeditionDB = false;
  await Firebase.initializeApp(
      // options: FirebaseOptions(
      //     apiKey: "AIzaSyDUEL4tF96lF4h0UVkIBKfK6kYAapOq6Kc", // Firebase 프로젝트 설정 - 웹 API 키
      //     appId: "1:429457628851:android:6e266711e43b9452511ac6", //google-service.json 에서 mobilesdk_app_id 부분
      //     messagingSenderId: "429457628851", // 클라우드 메시징 발신자 ID
      //     projectId: "lostark-adeline"), // Firebase 프로젝트 설정 - 프로젝트 ID
      );

  // 나중에 기본생성자에 print 넣고 실행되는지 확인하기
  // 실행되면 MultiProvider 에서 providers 에서 추가하는 ChangeNotifierProvider 이 무엇을 의미하는지 파악해야함.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InitSettingsController()),
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider(charactersProvider: CharacterProvider())),
        ChangeNotifierProvider(create: (context) => ExpeditionProvider()),
        ChangeNotifierProvider(create: (context) => AddContentProvider()),
        ChangeNotifierProvider(create: (context) => AddExpeditionContentProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()), // 생성자에서 저장된 값을 불러오면 되지 않을까?
        ChangeNotifierProvider(create: (context) => AddCharacterProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider themeChangeProvider = ThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = await themeChangeProvider.themePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => themeChangeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, instance, child) {
          return PlatformApp(
            material: (_, __) => MaterialAppData(
              theme: ThemeColor.themeData(themeChangeProvider.darkTheme, context),
              builder: (context, child) => MediaQuery(data: MediaQuery.of(context).copyWith(textScaleFactor: 1), child: child!),
            ),
            cupertino: (_, __) => CupertinoAppData(
              theme: CupertinoThemeData(
                textTheme: cupertinoTextTheme,
              ),
            ),
            // home: SplashMobileScreen(),
            home: userDB && expeditionDB ? BottomNavigationScreen() : InitSettingsScreen(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
