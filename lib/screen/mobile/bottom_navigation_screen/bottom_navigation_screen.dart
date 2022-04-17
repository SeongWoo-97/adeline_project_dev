import 'package:adeline_project_dev/screen/blank_screen.dart';
import 'package:adeline_project_dev/screen/mobile/characters_screen/characters_screen.dart';
import 'package:adeline_project_dev/screen/mobile/home_screen/home_screen.dart';
import 'package:adeline_project_dev/screen/mobile/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../model/dark_mode/dark_theme_provider.dart';
import '../Distribution_calu_Screen/distribution_calu_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 1);
  List<Widget> screens = [
    DistributionCaluScreen(),
    CharactersScreen(),
    HomeScreen(),
    SettingsScreen(),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.calculate_outlined),
        title: ("분배금"),
        activeColorPrimary: Colors.indigoAccent,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.calendar,
        ),
        title: ("숙제 관리"),
        activeColorPrimary: Colors.indigoAccent,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          CupertinoIcons.home,
        ),
        title: ("홈 화면"),
        activeColorPrimary: Colors.indigoAccent,
        inactiveColorPrimary: Colors.black54,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.menu),
        title: ("더보기"),
        activeColorPrimary: Colors.indigoAccent,
        inactiveColorPrimary: Colors.black54,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: screens,
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: themeProvider.darkTheme ? Colors.white54 : Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(5.0),
        colorBehindNavBar: themeProvider.darkTheme ? Colors.grey[800]! : Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 400),
      ),
      navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}
