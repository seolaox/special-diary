import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secret_diary/mainpage.dart';

import 'components/appbarwidget.dart';
import 'home.dart';
import 'test/datehandler.dart';
import 'test/sdiary.dart';

class EventUpdate extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
  const EventUpdate({super.key, required this.onChangeTheme});

  @override
  State<EventUpdate> createState() => _EventUpdateState();
}

enum IconType {
  Sunny,
  WaterDrop,
  Cloud,
  Air,
  AcUnit,
}

class _EventUpdateState extends State<EventUpdate> {
  late IconType selectedIcon;
  late DatabaseHandler handler;
  late TextEditingController titleController;
  late TextEditingController contentController;
  late int id;
  late String name;
  late Image image;
  late String iconweather;
  XFile? imageFile; //image picker를 정의한 타입 안드로이드 ios 둘 다 다루기 위해 정의한 타입이 xfile
  final ImagePicker picker = ImagePicker();
  var value = Get.arguments ?? "_";
  late bool checkGallery;
  late DateTime presentdate;
  late DateTime date;


  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    // date = DateTime.now();
    titleController = TextEditingController();
    contentController = TextEditingController();
    id = value[0];
    titleController.text = value[1];
    contentController.text = value[2];
    iconweather = getIconString(getIconTypeFromString(value[3]));
    selectedIcon = getIconTypeFromString(value[3]);
    image = Image.memory(value[6]);
    presentdate =
        value[7] != null ? DateTime.parse(value[7].toString()) : DateTime.now();
    checkGallery = false;
  }


      _changeThemeMode(ThemeMode themeMode) {
    //SettingPage에서도 themeMode사용하도록 widget설정
    widget.onChangeTheme(themeMode);
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
                '수정을 원하시면 사진을 클릭해 주세요.',
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
                  updateAction();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
//---FUNCTIONS---

  getImageFromGallery(ImageSource imageSource) async {
    //이미지 불러올때까지 기다려야 해서 async
    checkGallery = true;
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
          image: imageFile == null
              ? DecorationImage(
                  image: MemoryImage(value[6]),
                  fit: BoxFit.cover,
                )
              : DecorationImage(
                  image: FileImage(File(imageFile!.path)),
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  updateAction() async {
    //순서가 필요할때 무조건 async
    String title = titleController.text;
    String content = contentController.text;
    //file type을 byte type으로 변환하기

    if (checkGallery == true) {
      File imageFile1 = File(imageFile!.path); // imageFile경로를 file로 만들어 넣기
      Uint8List getImage =
          await imageFile1.readAsBytes(); //file type을 8type으로 변환
      var sdiaryUpdate = Sdiary(
          id: id,
          title: title,
          content: content,
          weathericon: getIconString(selectedIcon),
          lat: value[4],
          lng: value[5],
          image: getImage,
          actiondate: value[7]);
      await handler.updateSdiaryAll(sdiaryUpdate);
      _showDialog();
    } else {
      var sdiaryUpdate = Sdiary(
          id: id,
          title: title,
          content: content,
          weathericon: getIconString(selectedIcon),
          lat: value[4],
          lng: value[5],
          image: value[6],
          actiondate: value[7]);
      await handler.updateSdiary(sdiaryUpdate);
      _showDialog();
    }
  }

  _showDialog() {
    Get.defaultDialog(
        title: '수정결과',
        middleText: '수정이 완료되었습니다.',
        barrierDismissible: false,
        backgroundColor: const Color.fromARGB(255, 255, 210, 226),
        actions: [
          TextButton(
              onPressed: () {
                Get.to(()=>Home(onChangeTheme: _changeThemeMode));
              },
              child: Text('OK'))
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

Widget getIconWidget(String iconString) {
  print('Icon String: $iconString');
  switch (iconString.toLowerCase()) {
    case 'sunny':
      return Icon(Icons.sunny, color: Colors.amber[400],);
    case 'waterdrop':  // 'WaterDrop' 대신 'waterdrop'으로 수정
      return Icon(Icons.water_drop, color: Colors.blue[300]);
    case 'cloud':
      return Icon(Icons.cloud, color: Colors.grey[400],);
    case 'air':
      return Icon(Icons.air, color: Colors.blueGrey[200],);
    case 'acunit':  // 'AcUnit' 대신 'acunit'으로 수정
      return Icon(Icons.ac_unit, color: Colors.blue[100], );
    default:
      return Icon(Icons.error); // 기본값으로 오류 아이콘을 표시
  }
}

IconType getIconTypeFromString(String iconString) {
  switch (iconString) {
    case 'Sunny':
      return IconType.Sunny;
    case 'WaterDrop':
      return IconType.WaterDrop;
    case 'Cloud':
      return IconType.Cloud;
    case 'Air':
      return IconType.Air;
    case 'AcUnit':
      return IconType.AcUnit;
    default:
      return IconType.Sunny; 
  }
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
} //END
