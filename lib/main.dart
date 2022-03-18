import 'package:adeline_project_dev/constant/cupertino/cupertino_text_theme.dart';
import 'package:adeline_project_dev/constant/material/material_text_theme.dart';
import 'package:adeline_project_dev/screen/mobile/splash_screen/splash_mobile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() async{
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
          textTheme: materialTextTheme,
        ),
      ),
      cupertino: (_, __) => CupertinoAppData(
        theme: CupertinoThemeData(
          textTheme: cupertinoTextTheme,
        ),
      ),
      home: SplashMobileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
