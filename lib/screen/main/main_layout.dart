import 'dart:ui';

import 'package:adeline_app/model/dark_mode/android/android_light_theme_data.dart';
import 'package:adeline_app/model/dark_mode/dark_theme_provider.dart';
import 'package:adeline_app/model/dark_mode/responsive/rwd_dark_theme_data.dart';
import 'package:adeline_app/screen/main/controller/event_notice_controller.dart';
import 'package:adeline_app/screen/main/controller/notice_controller.dart';
import 'package:adeline_app/screen/main/desktop/desktop_main.dart';
import 'package:adeline_app/screen/main/mobile/mobile_main.dart';
import 'package:adeline_app/screen/main/tablet/tablet_main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/dark_mode/android/android_dark_theme_data.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    EventNoticeProvider eventNoticeProvider = Provider.of<EventNoticeProvider>(context, listen: false);
    NoticeProvider noticeProvider = Provider.of<NoticeProvider>(context, listen: false);
    // 모험섬
    noticeProvider.adventureIsland = noticeProvider.fetchAdventureIsland();
    // 공지사항
    noticeProvider.lostArkNotice = noticeProvider.fetchLostArkNotice();
    // 크리스탈
    noticeProvider.crystalPrice = noticeProvider.fetchCrystalMarketPrice();
    // 이벤트 목록, 하나로 통합
    eventNoticeProvider.lostArkEventNotice = eventNoticeProvider.fetchRwdLostArkEventNotice();
    eventNoticeProvider.mobileLostArkEventNotice = eventNoticeProvider.fetchLostArkEventNotice();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      navigatorObservers: observer.navigator == null ? [] : <NavigatorObserver>[observer],
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: DarkMode.isDarkMode,
          builder: (context, box, widget) {
            return Theme(
              data: fetchThemeData(MediaQuery.of(context).size),
              child: child!,
            );
          },
        );
      },
      home: LayoutBuilder(
        builder: (context, constraints) {
          // Desktop
          if (constraints.maxWidth >= 1024) {
            return DesktopMainScreen();
          }
          // Tablet
          if (constraints.maxWidth >= 768) {
            return TabletMainScreen();
          }
          // Mobile
          return MobileMainScreen();
        },
      ),
    );
  }

  ThemeData fetchThemeData(size) {
    if (size.width >= 1024) {
      return rwdDarkThemeData;
    }
    if (size.width >= 768) {
      return rwdDarkThemeData;
    }
    return DarkMode.isDarkMode.value ? androidDarkThemeData : androidLightThemeData;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
