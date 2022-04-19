import 'package:adeline_project_dev/screen/blank_screen.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/characters_screen.dart';
import 'package:adeline_project_dev/screen/mobile/home_screen/home_screen.dart';
import 'package:adeline_project_dev/screen/mobile/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../model/dark_mode/dark_theme_provider.dart';
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
    tabController = TabController(initialIndex: 1, vsync: this, length: 4);
    super.initState();
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
            CharactersScreen(),
            HomeScreen(),
            SettingsScreen(),
          ],
        ),
        material: (_, __) => MaterialScaffoldData(
          bottomNavBar: TabBar(
            controller: tabController,
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: 'home',
              ),
              Tab(
                icon: Icon(Icons.chat),
                text: 'chat',
              ),
              Tab(
                icon: Icon(Icons.people),
                text: 'my',
              ),
              Tab(
                icon: Icon(Icons.people),
                text: 'my',
              )
            ],
          ),
        ),
      ),
    );
  }
}
