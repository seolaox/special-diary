import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:secret_diary/components/appbarwidget.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';

import 'eventpage.dart';
import 'mainpage.dart';
import 'memopage.dart';
import 'setting.dart';

class Home extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;

  const Home({Key? key, required this.onChangeTheme}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

    _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
    widget.onChangeTheme(themeMode);
  }
  
  late MotionTabBarController _motionTabBarController;

  @override
  void initState() {
    super.initState();
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _motionTabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      appBar: AppBar(
        toolbarHeight: 65,
        title: AppbarTitle(),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primaryContainer,Theme.of(context).colorScheme.surfaceTint,],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
              
          ),),
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: [
            MainPage(onChangeTheme: _changeThemeMode),
            EventPage(onChangeTheme: _changeThemeMode),
            MemoPage(),
            Setting(onChangeTheme: _changeThemeMode) 
        ],
      ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController,
        initialSelectedTab: "Home",
        labels: const ["Home", "Event", "Memo", "Settings"],
        icons: const [
          Icons.home,
          Icons.event_note,
          Icons.format_list_bulleted,
          Icons.settings,
        ],
        tabSize: 35,
        tabBarHeight: 45,
        textStyle: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Theme.of(context).colorScheme.secondary,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Theme.of(context).colorScheme.primaryContainer,
        tabIconSelectedColor: Theme.of(context).colorScheme.secondary,
        tabBarColor: Theme.of(context).colorScheme.surface,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController.index = value;
          });
        },
      ),
    );
  }
}