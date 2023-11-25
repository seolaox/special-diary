import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:secret_diary/components/appbarwidget.dart';
import 'package:secret_diary/eventpage.dart';
import 'package:secret_diary/mainpage.dart';

import 'memopage.dart';
import 'setting.dart';

class Home extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme; 
  const Home({super.key, required this.onChangeTheme});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  
  _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
    widget.onChangeTheme(themeMode);
  }
  
  // property
  late TabController tabController;
  late bool iconTheme;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    iconTheme = true;
  }

  @override
  void dispose() {
    tabController.dispose();
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
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            MainPage(),
            EventPage(onChangeTheme: _changeThemeMode),
            MemoPage(),
            Setting(onChangeTheme: _changeThemeMode) 
          ]),
      // 화면 하단 탭바 설정
      bottomNavigationBar: 
      TabBar(
        controller: tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.home),
            text: "Home",
          ),
          Tab(
            icon: Icon(Icons.event_note),
            text: "Event",
          ),
          Tab(
            icon: Icon(Icons.format_list_bulleted),
            text: "Memo",
          ),
          Tab(
            icon: Icon(Icons.settings),
            text: "Setting",
          )
        ],
      ),
    );
  }
}
