import 'package:flutter/material.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:secret_diary/components/appbarwidget.dart';
// import 'package:motion_tab_bar_v2/motion-badge.widget.dart';

import 'eventpage.dart';
import 'mainpage.dart';
import 'memopage.dart';
import 'setting.dart';

class Home extends StatefulWidget {
  // 테마 변경을 감지하고 처리하기 위한 onChangeTheme 콜백 함수를 받음
  final Function(ThemeMode) onChangeTheme;
  const Home({Key? key, required this.onChangeTheme}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

//탭바의 모션을 위해 SingleTickerProviderStateMixin을 사용
class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

    //SettingPage에서도 themeMode사용하도록 widget설정
    _changeThemeMode(ThemeMode themeMode) {
    widget.onChangeTheme(themeMode);
  }
  
 
  late MotionTabBarController _motionTabBarController; 

  @override
  void initState() {
    super.initState();
     //탭의 상태 및 애니메이션을 관리하는 컨트롤러. 초기에 인덱스 0으로 설정되며, 총 4개의 탭으로 구성
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
  }

//위젯이 dispose될 때 컨트롤러도 함께 dispose되도록 구현
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
        title: const AppbarTitle(),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primaryContainer,Theme.of(context).colorScheme.surfaceTint,],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
              
          ),),
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _motionTabBarController,
        children: [
            MainPage(onChangeTheme: _changeThemeMode),
            EventPage(onChangeTheme: _changeThemeMode),
            const MemoPage(),
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