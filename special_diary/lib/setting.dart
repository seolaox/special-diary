import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secret_diary/components/appbarwidget.dart';
import 'package:secret_diary/service.dart';
import 'package:secret_diary/tutorial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
  const Setting({super.key, required this.onChangeTheme});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late bool iconTheme;
  late String themeName;



  @override
  void initState() {
    super.initState();
    iconTheme = false;
    loadIconTheme(); // 저장된 값 로드
    themeName = '다크 모드';
  }

  // 저장된 아이콘 테마 로드
  Future<void> loadIconTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      iconTheme = prefs.getBool('iconTheme') ?? false;
    });
  }

  // 아이콘 테마 저장
  Future<void> saveIconTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('iconTheme', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 239, 242),
                borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '버전',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                  SizedBox(
                    width: 280,
                  ),
                  Text(
                    'version',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(255, 146, 146, 146)),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => TermsOfService());
              },
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 239, 242),
                  borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '서비스 이용 약관',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                    SizedBox(
                      width: 200,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
            GestureDetector(
              onTap: () => Get.to(() => Tutorial()),
              child: Container(
                height: 60,
                width: 400,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 239, 242),
                  borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Tutorial',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                    SizedBox(
                      width: 261,
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
            Container(
              height: 60,
              width: 400,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 238, 239, 242),
                borderRadius: BorderRadius.circular(10), // 원하는 둥글기 정도를 설정
              ),
              child: Row(
                children: [
                  SizedBox(width: 20,),
                  Text(themeName,
                      style:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                  Spacer(), //항상 오른쪽 끝에 위치, 남는 공간을 채움
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (iconTheme == true) {
                            iconTheme = false;
                            themeName = '다크 모드';
                            widget.onChangeTheme(ThemeMode.light);
                          } else {
                            iconTheme = true;
                            themeName = '라이트 모드';
                            widget.onChangeTheme(ThemeMode.dark);
                          }
                          saveIconTheme(iconTheme); // 변경된 값 저장
                        });
                      },
                      icon: iconTheme == true
                          ? Icon(
                              Icons.sunny,
                              color: Colors.amber[300],
                              size: 28,
                            )
                          : Icon(
                              Icons.dark_mode,
                              color: Colors.amber[300],
                              size: 28,
                            ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 0.1,
              color: Colors.grey[450],
            ),
          ],
        ),
      ),
    );
  }
}
