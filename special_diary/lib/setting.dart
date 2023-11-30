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

  @override
  void initState() {
    super.initState();
    iconTheme = false;
    loadIconTheme(); // 저장된 값 로드
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
            Row(
              children: [
                SizedBox(width: 10,),
                Text('버전',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(width: 295,),
                Text('version',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.grey[400]),),
              ],
            ),
            Divider(thickness: 0.1,color: Colors.grey[450],),
            GestureDetector(
              onTap: () {
                Get.to(()=>TermsOfService());
              },
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Text('서비스 이용 약관',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                  SizedBox(width: 230,),
                  IconButton(
                    onPressed: () => Get.to(()=>TermsOfService()), 
                    icon: Icon(Icons.arrow_forward_ios),)
                ],
              ),
            ),
            Divider(thickness: 0.1,color: Colors.grey[450],),
              GestureDetector(
                onTap: () {
                Get.to(()=>Tutorial());
              },

                child: Row(
                children: [
                  SizedBox(width: 10,),
                  Text('Tutorial',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                  SizedBox(width: 291,),
                  IconButton(
                    onPressed: () {
                      Get.to(()=> Tutorial());
                    }, 
                    icon: Icon(Icons.arrow_forward_ios))
                ],
                          ),
              ),
            Divider(thickness: 0.1,color: Colors.grey[450],),


            Row(
              children: [
                SizedBox(width: 10),
                Text('테마 변경',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                SizedBox(width: 285),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (iconTheme == true) {
                        iconTheme = false;
                        widget.onChangeTheme(ThemeMode.light);
                      } else {
                        iconTheme = true;
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
              ],
            ),
            Divider(thickness: 0.1,color: Colors.grey[450],),
          ],
        ),
      ),
    );
  }
}


