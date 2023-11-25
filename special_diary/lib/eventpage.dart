import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secret_diary/eventinsert.dart';
import 'package:table_calendar/table_calendar.dart';

class EventPage extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme; 
  const EventPage({super.key, required this.onChangeTheme});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

      _changeThemeMode(ThemeMode themeMode) {
    widget.onChangeTheme(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 30,),
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            locale: "ko_KR",
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            focusedDay: focusedDay,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신합니다.	
              setState((){
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줍니다.	
              return isSameDay(selectedDay, day);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>EventInsert(onChangeTheme: _changeThemeMode) );
        },
        child: Icon(Icons.add),
        ),
        
    );
  }
  //---FUNCTIONS---

}
