import 'dart:io';
import 'dart:typed_data';
// import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_diary/components/appbarwidget.dart';
import 'package:secret_diary/home.dart';

import 'test/datehandler.dart';
import 'test/sdiary.dart';

class EventInsert extends StatefulWidget {
  const EventInsert({super.key});

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
  late MapController mapController;
  late Position currentPosition;
  late bool canRun;
  late double latData;
  late double lngData;
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();
  late DateTime date;
  // late DateTime date;   //location
  // late DateTime selectedDate; //날짜변경 버튼 누를 시 선택된 날짜
  // late String formattedDate; //전 페이지에서 선택한 날짜

  @override
  void initState() {
    super.initState();
      date = DateTime.now();
    handler = DatabaseHandler();
    titleController = TextEditingController();
    contentController = TextEditingController();
    mapController = MapController();
    canRun = false;
    // date = DateTime.now();
    // selectedDate = DateTime.now();
    // formattedDate = DateFormat('yyyy-MM-dd').format(date);

    checkLocationPermission();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 45, 0),
          child: AppbarTitle(),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
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
                padding: const EdgeInsets.fromLTRB(240, 10, 3, 0),
                child: Text('기념일 : 2023-11-30'),
                // child: Text('기념일 : ' + formattedDate'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(270, 0, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    disDatePicker();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(70, 30),
                    backgroundColor: Color.fromARGB(255, 154, 172, 243),
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
              SizedBox(
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
                    ?Color.fromARGB(255, 109, 147, 243)
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
                    ?Color.fromARGB(255, 109, 147, 243)
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
                    ?Color.fromARGB(255, 109, 147, 243)
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
                    ?Color.fromARGB(255, 109, 147, 243)
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
                      ?Color.fromARGB(255, 109, 147, 243)
                      :Colors.white,
                    ),
                    icon:
                        Icon(Icons.ac_unit, color: Colors.blue[100], size: 30),
                  ),
                ],
              ),

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
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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

              SizedBox(
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
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {

                    if (titleController.text.isEmpty ||
                          contentController.text.isEmpty ||
                          selectedIcon == null ||
                          imageFile == null
                          ) {
                          Get.snackbar(
                          "ERROR",
                          "모든 항목을 입력해 주세요.",
                          snackPosition: SnackPosition.BOTTOM,
                          duration: Duration(seconds: 2),
                          backgroundColor: Color.fromARGB(255, 247, 228, 162),
                        );
                              } else {
                              insertAction();
                              }
                  

                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 50),
                  // backgroundColor: Color.fromARGB(255, 146, 148, 255),
                  backgroundColor: Color.fromARGB(255, 151, 161, 252),
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

              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
//---FUNCTIONS---

//Map뜨기전에 동작하는 것 - await를 통해서 허가받을때까지 대기
  checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    //await하니까 뒤에 segment 함께 보임
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      //안쓴다 그러면 return
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      //사용할때만 쓰거나 항상 쓴다그러면 위치 값 받아오자
      getCurrentLocation();
    }
  }

  getCurrentLocation() async {
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position) {
      currentPosition = Position;
      canRun = true;
      latData = currentPosition.latitude;
      lngData = currentPosition.longitude;
      setState(() {});
      print(latData.toString() + ":" + lngData.toString());
    }).catchError((e) {
      print(e);
    });
  }

  // 이미지 가져오는 함수
  getImageFromGallery(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(
        source: imageSource); //카메라에서 찍고, 갤러리에서 선택된게 pickedFile로 들어감
    if (pickedFile == null) {
      //취소할 경우 처리
      return;
    } else {
      imageFile =
          XFile(pickedFile.path); //imageFile에는 경로를 넣어놨는데 xfile의 경로를 알려주는거
      setState(() {});
    }
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

  insertAction() async {
    //순서가 필요할때 무조건 async
    String title = titleController.text;
    String content = contentController.text;

    //file type을 byte type으로 변환하기
    File imageFile1 = File(imageFile!.path); // imageFile경로를 file로 만들어 넣기
    Uint8List getImage = await imageFile1.readAsBytes(); //file type을 8type으로 변환

    var sdiaryInsert = Sdiary(
      lat: latData,
      lng: lngData,
      title: title,
      content: content,
      weathericon: getIconString(selectedIcon),
      image: getImage,
      actiondate: DateTime.now(),
    );

    await handler.insertSdiary(sdiaryInsert);
    _showDialog();
  }

  _showDialog() {
    Get.defaultDialog(
        title: '입력결과', 
        titleStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
        middleText: '입력이 완료되었습니다.',
        middleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
        barrierDismissible: false,
        backgroundColor: Color.fromARGB(255, 174, 160, 221),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
                Get.back();
              },
              child: Text('OK', style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black, ),),)
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

//     // 날짜 변경 시 호출되는 함수
//   void updateFormattedDate() {
//     formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//     setState(() {});
//   }

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
    //   if (selectedDate != null) {
    //   // 날짜 선택 시 selectedDate 업데이트
    //   this.selectedDate = selectedDate;
    //   // formattedDate 업데이트 함수 호출
    //   updateFormattedDate();
    // }
  }
} //END
