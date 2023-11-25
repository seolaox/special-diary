import 'package:flutter/material.dart';
import 'package:secret_diary/components/appbarwidget.dart';

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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        ),
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
            Row(
              children: [
                SizedBox(width: 10,),
                Text('서비스 이용 약관',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(width: 225,),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            Divider(thickness: 0.1,color: Colors.grey[450],),
              Row(
              children: [
                SizedBox(width: 10,),
                Text('Tip',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(width: 328,),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
            Divider(thickness: 0.1,color: Colors.grey[450],),
            Row(
              children: [
                SizedBox(width: 10,),
                Text('테마 변경',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(width: 270,),
                IconButton(
                  onPressed: () {
                    setState(() {
              if(iconTheme==true){
              iconTheme =false;
              widget.onChangeTheme(ThemeMode.light);
              }else{
              iconTheme = true;
              widget.onChangeTheme(ThemeMode.dark);
              }
              });
            },
              icon: iconTheme==true
              ? Icon(Icons.sunny, color: Colors.amber[300],size: 28,)
              : Icon(Icons.dark_mode, color: Colors.amber[300],size: 28,),)
              ],
            ),
              Divider(thickness: 0.1,color: Colors.grey[450],),
          ],
        ),
      ),
    );
  }
}