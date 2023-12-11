import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_diary/components/appbarwidget.dart';
import 'package:secret_diary/home.dart';
import 'package:secret_diary/model/datehandler.dart';

import 'model/sdiary.dart';


class EventInsert extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
    final DateTime? selectedDay; //전페이지에서 selectedDay값 받아오기
  const EventInsert({super.key, this.selectedDay, required this.onChangeTheme});

  @override
  State<EventInsert> createState() => _EventInsertState();
}

enum IconType {
  Sunny,
  WaterDrop,
  Cloud,
  Air,
  AcUnit,
}




class _EventInsertState extends State<EventInsert> {
  late IconType selectedIcon = IconType.Sunny;
  late DatabaseHandler handler;
  late TextEditingController titleController;
  late TextEditingController contentController;
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  late DateTime date;

  late DateTime selectedDate; //날짜변경 버튼 누를 시 선택된 날짜
  late String formattedDate; //전 페이지에서 선택한 날짜


    _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
    widget.onChangeTheme(themeMode);
  }
  

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    handler = DatabaseHandler();
    titleController = TextEditingController();
    contentController = TextEditingController();
    // date = DateTime.now();
    selectedDate = widget.selectedDay ?? date; // widget을 통해 selectedDay 값을 받아오기
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 45, 0),
          child: AppbarTitle(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
              colors: [Theme.of(context).colorScheme.primaryContainer,Theme.of(context).colorScheme.surfaceTint,],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
              
          ),),
        // backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(290, 10, 3, 0),
                child: Row(
                  children: [
                    const Icon(Icons.event_available_outlined),
                    const SizedBox(width: 5,),
                    Text(formattedDate,style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(270, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    disDatePicker();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(70, 30),
                    backgroundColor: const Color.fromARGB(255, 154, 172, 243),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "날짜 변경",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 234, 236),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                            selectedIcon = IconType.Sunny;
                          });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: selectedIcon == IconType.Sunny
                    ?const Color.fromARGB(255, 109, 147, 243)
                      : Colors.white,
                    ),
                    icon: Icon(Icons.sunny, color: Colors.amber[400], size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                        setState(() {
                            selectedIcon = IconType.WaterDrop;
                          });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: selectedIcon == IconType.WaterDrop
                    ?const Color.fromARGB(255, 109, 147, 243)
                      : Colors.white,
                    ),
                    icon: Icon(Icons.water_drop,
                        color: Colors.blue[300], size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                            selectedIcon = IconType.Cloud;
                          });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: selectedIcon == IconType.Cloud
                    ?const Color.fromARGB(255, 109, 147, 243)
                      :Colors.white,
                    ),
                    icon: Icon(Icons.cloud, color: Colors.grey[400], size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                          setState(() {
                      selectedIcon = IconType.Air;
                          });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: selectedIcon == IconType.Air
                    ?const Color.fromARGB(255, 109, 147, 243)
                      : Colors.white,
                    ),
                    icon:
                        Icon(Icons.air, color: Colors.blueGrey[200], size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                        setState(() {
                            selectedIcon = IconType.AcUnit;
                          });
                    },
                    style: IconButton.styleFrom(
                      backgroundColor: selectedIcon == IconType.AcUnit
                      ?const Color.fromARGB(255, 109, 147, 243)
                      :Colors.white,
                    ),
                    icon:
                        Icon(Icons.ac_unit, color: Colors.blue[100], size: 30),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
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
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
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
                    fontSize: 18,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
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
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  
                    if(titleController.text.isEmpty ||
                          contentController.text.isEmpty){
                          Get.snackbar(
                          "ERROR", 
                          "모든 항목을 입력해 주세요.",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                          colorText: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 247, 228, 162),
                        );
                          }else if(imageFile == null){
                            Get.snackbar(
                          "ERROR",
                          "사진을 선택해 주세요.",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                          colorText: Colors.black,
                          backgroundColor: const Color.fromARGB(255, 248, 201, 168),);
                          }else{
                              insertAction();
                          }
                  

                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  // backgroundColor: Color.fromARGB(255, 146, 148, 255),
                  backgroundColor: const Color.fromARGB(255, 159, 168, 249),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "입력",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 234, 234, 236),
                  ),
                ),
              ),

              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
//---FUNCTIONS---

  
  // 이미지 가져오는 함수
getImageFromGallery(ImageSource imageSource) async {
  try {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    
    if (pickedFile == null) {
      // 사용자가 이미지 선택을 취소한 경우
      return;
    } else {
      imageFile = XFile(pickedFile.path);
      setState(() {});
    }
  } catch (e) {
    // 예외 처리
    if (e is PlatformException && e.code == 'photo_access_denied') {
      // 사용자가 사진 액세스를 거부한 경우
      showPhotoAccessDeniedDialog();
    } 
  }
}

void showPhotoAccessDeniedDialog() {
  // 사용자에게 사진 액세스 권한이 필요하다는 메시지를 표시
  Get.defaultDialog(
    title: '사진 액세스 거부됨',
    titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.black),
    middleText: '사진 액세스 권한이 필요합니다. \n 설정에서 권한을 부여해주세요.',
    middleTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.black),
    backgroundColor: Theme.of(context).colorScheme.errorContainer,
    actions: [TextButton(
      onPressed: () {
        Get.back();
      }, child: const Text('Exit',style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900,color: Color.fromARGB(255, 253, 109, 109),),))]
    );

}


  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        getImageFromGallery(ImageSource.gallery);
      },
      child: Container(
        width: 350,
        height: 210,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 212, 221, 247),
          image: imageFile != null
              ? DecorationImage(
                  image: FileImage(File(imageFile!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageFile == null
            ? const Icon(
                Icons.add_a_photo,
                size: 48,
                color: Colors.grey,
              )
            : null,
      ),
    );
  }

insertAction() async {
  // 순서가 필요할 때는 무조건 async
  String title = titleController.text;
  String content = contentController.text;

  // file type을 byte type으로 변환하기
  File imageFile1 = File(imageFile!.path); // imageFile 경로를 file로 만들어 넣기
  Uint8List getImage = await imageFile1.readAsBytes(); // file type을 8type으로 변환

  // formattedDate를 그대로 사용
  String eventDate = formattedDate;

  var sdiaryInsert = Sdiary(
    title: title,
    content: content,
    weathericon: getIconString(selectedIcon),
    image: getImage,
    actiondate: DateTime.now(),
    eventdate: eventDate, // formattedDate를 String으로 그대로 할당
  );

  await handler.insertSdiary(sdiaryInsert);
  _showDialog();
}


  _showDialog() {
    Get.defaultDialog(
        title: '입력결과', 
        titleStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black, ),
        middleText: '입력이 완료되었습니다.',
        middleTextStyle: const TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black, ),
        barrierDismissible: false,
        backgroundColor: const Color.fromARGB(255, 210, 220, 255),
        // backgroundColor: Color.fromARGB(255, 210, 220, 255),
        // backgroundColor: Color.fromARGB(255, 255, 210, 226),
        actions: [
          TextButton(
              onPressed: () {
                Get.offAll(() => Home(onChangeTheme: _changeThemeMode), arguments: 0); //모두끄고 arguments로 0번째 페이지로 보내기
              },
              child: const Text('OK', style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black, ),),)
        ]);
  }

  // IconType을 문자열로 변환하기 위한 도우미 함수
  String getIconString(IconType icon) {
    switch (icon) {
      case IconType.Sunny:
        return 'Sunny';
      case IconType.WaterDrop:
        return 'WaterDrop';
      case IconType.Cloud:
        return 'Cloud';
      case IconType.Air:
        return 'Air';
      case IconType.AcUnit:
        return 'AcUnit';
    }
  }

    // 날짜 변경 시 호출되는 함수
  void updateFormattedDate() {
    formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
    setState(() {});
  }

disDatePicker()async{
    //캘린더 날짜 범위 설정하기
   int firstYear = date.year -23; //전년도 까지만 보기
   int lastYear = firstYear + 100; //5년뒤 까지 보기
   final selectedDate = await showDatePicker(  //showDatePicker 화면을 구성하고 사용자가 selectedDate선택해서 값 받아올때까지 await 기다려
    //selectedDate는 showDatePicker에서 가져온 데이터라 String이 아님
    context: context,
    initialDate: date,
    firstDate: DateTime(firstYear),
    lastDate: DateTime(lastYear),
    initialEntryMode: DatePickerEntryMode.calendarOnly, //캘린더로 설정하기
    locale: const Locale('ko','KR') //한국시간으로 바꿔서 보여주기
  );
      if (selectedDate != null) {
      // 날짜 선택 시 selectedDate 업데이트
      this.selectedDate = selectedDate;
      // formattedDate 업데이트 함수 호출
      updateFormattedDate();
    }
  }
} //END
