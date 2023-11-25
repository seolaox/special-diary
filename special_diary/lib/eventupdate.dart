import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EventUpdate extends StatefulWidget {
  const EventUpdate({super.key});

  @override
  State<EventUpdate> createState() => _EventUpdateState();
}

class _EventUpdateState extends State<EventUpdate> {


  // late DatabaseHandler handler;
  late TextEditingController titleController;
  late TextEditingController contentController;
  XFile? imageFile; 
  final ImagePicker picker = ImagePicker();
  late DateTime date; 
  late String selectDateText;

  var value = Get.arguments ?? "_";

  @override
  void initState() {
    super.initState();
        // handler = DatabaseHandler();
    titleController = TextEditingController();  
    contentController = TextEditingController();  
    date = DateTime.now();
    selectDateText = "";
  }

    // 이미지 가져오는 함수
  Future getImage(ImageSource imageSource) async {
   final XFile? pickedFile = await picker.pickImage(source: imageSource); //카메라에서 찍고, 갤러리에서 선택된게 pickedFile로 들어감
  if(pickedFile == null){ //취소할 경우 처리
    return;
  }else{
    imageFile = XFile(pickedFile.path); //imageFile에는 경로를 넣어놨는데 xfile의 경로를 알려주는거
    setState(() {});
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 70,
        title: Text('Special Diary'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(250, 10, 3, 0),
                child: Text('2023-11-30'),
              ),
              ElevatedButton(
                onPressed: () => disDatePicker(),
                child: Text('날짜 변경')),
              Padding(
              padding: const EdgeInsets.fromLTRB(3, 10, 3, 3),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title ',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: 'Content ',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 13,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20,),
                Text(
                  '특별한 날을 기념할 사진을 등록해 주세요',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 0, width: double.infinity),
                _buildImagePicker(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // 이미지 저장 여부를 확인하여 다음 화면으로 이동
                    // checkImagesStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 50),
                    backgroundColor: Color.fromARGB(255, 146, 148, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "수정",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 234, 236),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
//---FUNCTIONS---






  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
          getImage(ImageSource.gallery);
      },
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 212, 221, 247),
          image: imageFile != null
              ? DecorationImage(
                  image: FileImage(File(imageFile!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageFile == null
            ? Icon(
                Icons.add_a_photo,
                size: 48,
                color: Colors.grey,
              )
            : null,
      ),
    );
  }

disDatePicker()async{
    //캘린더 날짜 범위 설정하기
   int firstYear = date.year -1; //전년도 까지만 보기
   int lastYear = firstYear + 5; //5년뒤 까지 보기
   final selectedDate = await showDatePicker(  //showDatePicker 화면을 구성하고 사용자가 selectedDate선택해서 값 받아올때까지 await 기다려 
    //selectedDate는 showDatePicker에서 가져온 데이터라 String이 아님
    context: context, 
    initialDate: date, 
    firstDate: DateTime(firstYear), 
    lastDate: DateTime(lastYear),
    initialEntryMode: DatePickerEntryMode.calendarOnly, //캘린더로 설정하기
    locale: Locale('ko','KR') //한국시간으로 바꿔서 보여주기
  );
  }







}//END