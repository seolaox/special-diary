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
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
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
              const SizedBox(height: 20,),
              const Text('- TUTORIAL -',style: TextStyle(fontSize: 21,fontWeight: FontWeight.w900),),
                            SizedBox(height: 20,),
              const Text('1. Date 선택 ',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/eventpage.png',width: 150,height: 300,),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('기록할 날짜를 지정 후 +버튼을 누르면 입력창으로 이동합니다.',),
              const SizedBox(height: 60,),
              const Text('2. Event 입력',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/eventinsert.png',width: 150,height: 300,),
                ],
              ),
              const SizedBox(height: 15,),
              const Text('날씨, 제목, 내용, 사진을 선택하여',),
              const Text('버튼을 누를 시 기록한 내용이 저장됩니다.',),

              const SizedBox(height: 60,),
              const Text('3. Home 화면',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/homeview.png',width: 130,height: 270,),
              Image.asset('images/eventsearch.png',width: 130,height: 270,),
              Image.asset('images/eventdetail.png',width: 130,height: 270,),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('앱을 실행할 때 구성되는 첫 화면입니다.'),
              const Text('입력한 내용을 검색하면 키워드 검색으로 해당 기록물만 띄워줍니다.'),
              const Text('기록물을 클릭 시 입력한 내용을 자세히 볼 수 있습니다.'),
              const SizedBox(height: 50,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/eventupdate.png',width: 150,height: 300,),
              Image.asset('images/datepicker.png',width: 150,height: 300,),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('해당 카드를 오른쪽으로 밀고 edit를 클릭 시 수정 페이지로 이동합니다.'),
              const Text('날짜,날씨,제목,내용,사진등을 변경할 수 있습니다.'),
              const SizedBox(height: 50,),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/eventdelete.png',width: 150,height: 300,),
              Image.asset('images/deletesheet.png',width: 150,height: 300,),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('해당 카드를 왼쪽으로 밀고 delete를 클릭 시 삭제할 수 있습니다.'),
              const SizedBox(height: 60,),
              
              const Text('4. Memo 입력',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/memoinsert.png',width: 130,height: 270,),
              Image.asset('images/memoupdate.png',width: 130,height: 270,),
              Image.asset('images/memodelete.png',width: 130,height: 270,),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('+버튼 누르면 입력창을 띄웁니다.'),
              const Text('해당 카드를 클릭하거나 오른쪽으로 밀면 수정,'),
              const Text('왼쪽으로 밀면 삭제할 수 있습니다.'),
              const SizedBox(height: 50,),
              const Text('5. Theme 변경',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/lighttheme.png',width: 150,height: 300,),
              Image.asset('images/darktheme.png',width: 150,height: 300,),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('해, 달 이모티콘을 클릭 시 테마 변경이 가능합니다.'),
              const SizedBox(height: 50,),
              const Text('6. 사진 권한',style: TextStyle(fontSize: 19,fontWeight: FontWeight.w700),),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/photoaccess.png',width: 150,height: 300,),
                ],
              ),
              const SizedBox(height: 10,),
              const Text('사진 권한이 없다는 창이 뜨면'),
              const Text('설정 → 개인정보 보호 및 보안 → 사진'),
              const Text('APP의 접근 권한을 바꿔주세요.'),
              const SizedBox(height: 50,),
              const Text('글씨체제작: 강원도교육청X혜움디자인',style: TextStyle(fontSize: 10),),
              const SizedBox(height: 70,),
            ],  
          ),
        ),
      ),
    );
  }
}
