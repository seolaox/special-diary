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
      initialIndex: 1,
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
        toolbarHeight: 70,
        title: AppbarTitle(),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: [
            MainPage(),
            EventPage(),
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
        tabSize: 50,
        tabBarHeight: 50,
        textStyle: const TextStyle(
          fontSize: 15,
          // color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        tabIconColor: Color.fromARGB(255, 40, 40, 40),
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Color.fromARGB(255, 123, 108, 236),
        tabIconSelectedColor:Color.fromARGB(255, 29, 28, 28),
        tabBarColor:Color.fromARGB(255, 191, 184, 243),
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController.index = value;
          });
        },
      ),
    );
  }
}
