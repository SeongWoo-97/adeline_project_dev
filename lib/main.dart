import 'package:adeline_project_dev/constant/cupertino/cupertino_text_theme.dart';
import 'package:adeline_project_dev/constant/material/material_text_theme.dart';
import 'package:adeline_project_dev/screen/mobile/init_screen/initSettings_screen.dart';
import 'package:adeline_project_dev/screen/mobile/splash_screen/splash_mobile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      material: (_, __) => MaterialAppData(
        theme: ThemeData(
          textTheme: TextTheme(
            headline1: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black),
            bodyText1: TextStyle(
              fontSize: 16,
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
