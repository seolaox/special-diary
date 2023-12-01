import 'package:flutter/material.dart';

class AppbarTitle extends StatelessWidget {
  const AppbarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('My Special Diary',style: TextStyle( fontSize: 28,fontWeight: FontWeight.w700),),
        SizedBox(width: 5,),
        Icon(Icons.edit_calendar)
        // Icon(Icons.volunteer_activism)
      ],
    );
  }
}