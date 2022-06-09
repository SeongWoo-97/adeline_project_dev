import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../../../service/firebase_service.dart';
import '../characters_slot_screen/init_screen/initSettings_screen.dart';


class GoogleSignInMobileScreen extends StatefulWidget {
  const GoogleSignInMobileScreen({Key? key}) : super(key: key);

  @override
  State<GoogleSignInMobileScreen> createState() => _GoogleSignInMobileScreenState();
}

class _GoogleSignInMobileScreenState extends State<GoogleSignInMobileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      material: (_, __) => MaterialScaffoldData(),
      cupertino: (_, __) => CupertinoPageScaffoldData(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'LOST ARK\nAdeline',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.blue[500]),
                textAlign: TextAlign.center,
              ),
              PlatformWidget(
                material: (_, __) => OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                  ),
                  onPressed: () async {
                    // FirebaseService service = FirebaseService();
                    try {
                      // await service.signInGoogle();
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => InitSettingsScreen()), (route) => false);
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        print(e.message!);
                      }
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/google_logo.png',
                        scale: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '시작하기',
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                cupertino: (_, __) => OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 2,
                  ),
                  onPressed: () async {
                    FirebaseService service = FirebaseService();
                    try {
                      await service.signInGoogle();
                      Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => InitSettingsScreen()), (route) => false);
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        print(e.message!);
                      }
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/google_logo.png',
                        scale: 25,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '시작하기',
                        style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
