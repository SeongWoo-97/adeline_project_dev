import 'package:adeline_project_dev/constant/cupertino/cupertino_text_theme.dart';
import 'package:adeline_project_dev/model/add_content_provider/add_content_provider.dart';
import 'package:adeline_project_dev/model/add_content_provider/add_expedition_content_provider.dart';
import 'package:adeline_project_dev/model/user/user_provider.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/controller/initSettings_controller.dart';

import 'package:adeline_project_dev/model/user/character/character_provider.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/initSettings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'model/user/expedition/expedition_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InitSettingsController()),
        ChangeNotifierProvider(create: (context) => CharacterProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider(charactersProvider: CharacterProvider())),
        ChangeNotifierProvider(create: (context) => ExpeditionProvider()),
        ChangeNotifierProvider(create: (context) => AddContentProvider()),
        ChangeNotifierProvider(create: (context) => AddExpeditionContentProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      material: (_, __) => MaterialAppData(
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(fontFamily: 'NotoSansKR', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
            bodyText1: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'NotoSansKR',
            ),
            bodyText2: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontFamily: 'NotoSansKR',
            ),
            caption: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontFamily: 'NotoSansKR',
            ),
          ),
        ),
      ),
      cupertino: (_, __) => CupertinoAppData(
        theme: CupertinoThemeData(
          textTheme: cupertinoTextTheme,
        ),
      ),
      // home: SplashMobileScreen(),
      home: InitSettingsScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
