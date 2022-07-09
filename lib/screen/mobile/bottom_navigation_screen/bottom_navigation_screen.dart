import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:hive/hive.dart';

import '../Distribution_calu_Screen/distribution_calu_screen.dart';
import '../characters_slot_screen/character_select_screen/character_select_screen.dart';
import '../characters_slot_screen/characters_slot_screen.dart';
import '../home_screen/home_screen.dart';
import '../settings_screen/settings_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  final int? index;

  BottomNavigationScreen({this.index});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(initialIndex: widget.index ?? Hive.box('firstScreen').get('index', defaultValue: 2), vsync: this, length: 4);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
  }
}
