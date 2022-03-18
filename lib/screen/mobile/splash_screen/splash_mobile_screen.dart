import 'package:adeline_project_dev/screen/mobile/google_sign_screen/google_sign_mobile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashMobileScreen extends StatefulWidget {
  const SplashMobileScreen({Key? key}) : super(key: key);

  @override
  State<SplashMobileScreen> createState() => _SplashMobileScreenState();
}

class _SplashMobileScreenState extends State<SplashMobileScreen> {
  @override
  void initState() {
    super.initState();
    // 네트워크 연결상태
    // 권한 획득
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      body: SafeArea(
        child: SplashScreenView(
          navigateRoute: GoogleSignInMobileScreen(),
          text: 'LOST ARK\nAdeline',
          duration: 3000,
          textType: TextType.ColorizeAnimationText,
          backgroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
