import 'package:flutter/material.dart';

import 'components/appbarwidget.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 65,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 45, 0),
          child: AppbarTitle(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surfaceTint,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        
            children: [
              SizedBox(height: 20,),
              Text('- TUTORIAL -',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w900),),
                            SizedBox(height: 20,),
              Text('1. 날짜 선택 ',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/eventpage.png',width: 150,height: 300,),
                ],
              ),
              SizedBox(height: 10,),
              Text('기록할 날짜를 지정 후 +버튼을 누르면 입력창으로 이동합니다.',),
              SizedBox(height: 60,),
              Text('2. Event입력',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/eventinsert.png',width: 150,height: 300,),
                ],
              ),
                  SizedBox(height: 15,),
              Text('날씨, 제목, 내용, 사진을 선택하여',),
              Text('버튼을 누를 시 기록한 내용이 저장됩니다.',),

              SizedBox(height: 60,),
              Text('3. Home화면',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/homeview.png',width: 150,height: 300,),
              Image.asset('images/eventsearch.png',width: 150,height: 300,),
                ],
              ),
              SizedBox(height: 10,),
              Text('앱을 실행할 때 구성되는 첫 화면입니다.'),
              Text('입력한 내용을 검색하면 키워드 검색으로 해당 기록물만 띄워줍니다.'),
              SizedBox(height: 50,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/eventupdate.png',width: 150,height: 300,),
              Image.asset('images/eventpicker.png',width: 150,height: 300,),
                ],
              ),
              SizedBox(height: 10,),
              Text('해당 카드를 오른쪽으로 밀고 edit를 클릭 시 수정 페이지로 이동합니다.'),
              Text('날짜,날씨,제목,내용,사진등을 변경할 수 있습니다.'),
              SizedBox(height: 50,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/eventdeletecard.png',width: 150,height: 300,),
              Image.asset('images/eventdeletesheet.png',width: 150,height: 300,),
                ],
              ),
              SizedBox(height: 10,),
              Text('해당 카드를 왼쪽으로 밀고 delete를 클릭 시 삭제할 수 있습니다.'),
              SizedBox(height: 60,),
              Text('4. Map 화면',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/mapview.png',width: 150,height: 300,),
                  Column(
              
                    children: [
                      Text('해당 카드를 길게 누르면'),
                      Text('기록한 곳의 장소를'),
                      Text('띄워줍니다.'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60,),
              Text('5. Memo입력',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/memoinsert.png',width: 130,height: 270,),
              Image.asset('images/memoupdate.png',width: 130,height: 270,),
              Image.asset('images/memodelete.png',width: 130,height: 270,),
                ],
              ),
              SizedBox(height: 10,),
              Text('+버튼 누르면 입력창을 띄웁니다.'),
              Text('해당 카드를 클릭하거나 오른쪽으로 밀면 수정,'),
              Text('왼쪽으로 밀면 삭제할 수 있습니다.'),
              SizedBox(height: 50,),
              Text('6. Theme 변경',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/lighttheme.png',width: 150,height: 300,),
              Image.asset('images/darktheme.png',width: 150,height: 300,),
                ],
              ),
              SizedBox(height: 10,),
              Text('해, 달 이모티콘을 누를 시 테마 변경이 가능합니다.'),
              SizedBox(height: 70,),
              
              
            ],
              
          ),
        ),
      ),
    );
  }
}
