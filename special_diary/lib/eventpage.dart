import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secret_diary/eventinsert.dart';
import 'package:secret_diary/model/specialdiary.dart';
import 'package:table_calendar/table_calendar.dart';


class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  DateTime? selectedDay;

  // DateTime selectedDay = DateTime(
  //   DateTime.now().year,
  //   DateTime.now().month,
  //   DateTime.now().day,
  // );

  DateTime focusedDay = DateTime.now();



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
          // _openEventInsertPage();

          Get.to(()=>EventInsert());
        },
        child: Icon(Icons.add),
        ),
        
    );
  }
  //---FUNCTIONS---

  //     void _openEventInsertPage() {
  //   if (selectedDay == null) {
  //     Get.snackbar(
  //       'ERROR', 
  //       '글을 작성할 날짜를 선택해 주세요!',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Color.fromARGB(255, 122, 164, 249),
  //     );
  //   } else {
  //     Get.to(() => EventInsert(onChangeTheme: widget.onChangeTheme), arguments: selectedDay);
  //   }
  // }


}
