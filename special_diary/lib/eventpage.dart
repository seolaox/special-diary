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
  DateTime? selectedDay;
    DateTime focusedDay = DateTime.now();

    _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
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
          _openEventInsertPage(selectedDay);

          // Get.to(()=>EventInsert());
        },
        child: Icon(Icons.add),
        ),
        
    );
  }
  //---FUNCTIONS---

      void _openEventInsertPage(DateTime? selectedDay) {
    if (selectedDay == null) {
      Get.snackbar(
        'ERROR', 
        '글을 작성할 날짜를 선택해 주세요.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Color.fromARGB(255, 247, 228, 162),
      );
    } else {
      Get.to(() => EventInsert(selectedDay: selectedDay, onChangeTheme: _changeThemeMode,));
    }
  }




}
