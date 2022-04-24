import 'package:adeline_project_dev/screen/blank_screen.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/characters_screen.dart';
import 'package:adeline_project_dev/screen/mobile/home_screen/home_screen.dart';
import 'package:adeline_project_dev/screen/mobile/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../Distribution_calu_Screen/distribution_calu_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 1, vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: PlatformScaffold(
        body: TabBarView(
          controller: tabController,
          children: [
            DistributionCaluScreen(),
            CharactersScreen(),
            // HomeScreen(),
            // BlankScreen(),
            SettingsScreen(),
          ],
        ),
        material: (_, __) => MaterialScaffoldData(
          bottomNavBar: Container(
            height: 60,
            child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(border: Border(top: BorderSide(width: 3.5, color: Theme.of(context).indicatorColor))),
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
                // Tab(
                //   icon: Icon(Icons.home_outlined),
                //   text: '홈 화면',
                // ),
                // Tab(
                //   icon: Icon(Icons.build_outlined),
                //   text: '미정',
                // ),
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
