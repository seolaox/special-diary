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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text('TUTORIAL',),
              SizedBox(height: 20,),
              Text('1. Home화면'),
      
              
              
              Text('2. Event화면 '),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Image.asset('images/eventfirst.png',width: 150,height: 300,),
              Image.asset('images/eventsecond.png',width: 150,height: 300,),
                ],
              ),
              Text('기록할 날짜를 지정 후 +버튼 누르면 입력창으로 이동합니다.'),
              Text('2. Event입력'),
              Text('3. Memo입력'),
      
              
            ],
      
          ),
        ),
      ),
    );
  }
}
