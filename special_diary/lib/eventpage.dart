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
          const SizedBox(height: 20,),
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2099, 12, 31),
            locale: "ko_KR",
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            focusedDay: focusedDay,
            onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
              // 선택된 날짜의 상태를 갱신.
              setState((){
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (DateTime day) {
              // selectedDay 와 동일한 날짜의 모양을 바꿔줌.
              return isSameDay(selectedDay, day);
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openEventInsertPage(selectedDay);
        },
        child: const Icon(Icons.add),
        ),
        
    );
  }
  //---FUNCTIONS---

//날짜를 선택하지 않으면 페이지가 넘어가지 않음
      void _openEventInsertPage(DateTime? selectedDay) {
    if (selectedDay == null) {
      Get.snackbar(
        'ERROR', 
        '글을 작성할 날짜를 선택해 주세요.',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.black,
        backgroundColor: const Color.fromARGB(255, 247, 228, 162),
      );
    } else {
      Get.to(() => EventInsert(selectedDay: selectedDay, onChangeTheme: _changeThemeMode,));
    }
  }




}
