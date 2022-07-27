import 'package:adeline_app/model/dark_mode/dark_theme_provider.dart';
import 'package:adeline_app/screen/distribution_calculator/distribution_calculator.dart';
import 'package:adeline_app/screen/home_work/characters_isExist/character_select_screen.dart';
import 'package:adeline_app/screen/main/mobile/home_screen/home_screen.dart';
import 'package:adeline_app/screen/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';

class MobileMainScreen extends StatefulWidget {
  final int? index;

  MobileMainScreen({this.index});

  @override
  State<MobileMainScreen> createState() => _MobileMainScreenState();
}

class _MobileMainScreenState extends State<MobileMainScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(initialIndex: widget.index ?? Hive.box('firstScreen').get('index', defaultValue: 2), vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: DarkMode.isDarkMode,
      builder: (context, box, widget) {
        return DefaultTabController(
          length: 4,
          child: PlatformScaffold(
            body: TabBarView(
              controller: tabController,
              children: [
                DistributionCaluScreen(),
                CharacterSelectScreen(),
                HomeScreen(),
                SettingsScreen(),
              ],
            ),
            material: (_, __) => MaterialScaffoldData(
              bottomNavBar: Container(
                height: 60,
                child: TabBar(
                  controller: tabController,
                  indicator: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 3.5, color: Theme.of(context).indicatorColor),
                    ),
                  ),
                  labelStyle: Theme.of(context).textTheme.caption,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.calculate_outlined),
                      iconMargin: const EdgeInsets.only(bottom: 2),
                      child: Text('분배금'),
                    ),
                    Tab(
                      icon: Icon(Icons.edit_calendar_outlined),
                      iconMargin: const EdgeInsets.only(bottom: 2),
                      text: '숙제 관리',
                    ),
                    Tab(
                      icon: Icon(Icons.home_outlined),
                      iconMargin: const EdgeInsets.only(bottom: 2),
                      text: '홈 화면',
                    ),
                    Tab(
                      icon: Icon(Icons.settings_outlined),
                      iconMargin: const EdgeInsets.only(bottom: 2),
                      text: '설정',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
