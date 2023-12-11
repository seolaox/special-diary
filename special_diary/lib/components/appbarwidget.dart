import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('오늘의 이야기',style: TextStyle( fontSize: 25,fontWeight: FontWeight.w700),),
        SizedBox(width: 5,),
        Icon(Icons.edit_calendar)
        // Icon(Icons.volunteer_activism)
      ],
    );
  }
}