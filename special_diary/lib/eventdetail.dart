import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:secret_diary/eventupdate.dart' as update;
import 'package:secret_diary/model/datehandler.dart';
import 'components/appbarwidget.dart';
import 'eventinsert.dart';

class EventDetail extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme;
  const EventDetail({super.key, required this.onChangeTheme});

  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  late IconType selectedIcon;
  late DatabaseHandler handler;
  late TextEditingController titleController;
  late TextEditingController contentController;
  late int id;
  late String name;
  late Image image;
  XFile? imageFile; //image picker를 정의한 타입 안드로이드 ios 둘 다 다루기 위해 정의한 타입이 xfile
  final ImagePicker picker = ImagePicker();
  var value = Get.arguments ?? "_";
  late bool checkGallery;
  late DateTime presentdate;
  late DateTime eventUpdateDate;
  late DateTime selectedDate; //날짜변경 버튼 누를 시 선택된 날짜
  late String formattedDate; //전 페이지에서 선택한 날짜

    //SettingPage에서도 themeMode사용하도록 widget설정
      _changeThemeMode(ThemeMode themeMode) {
    widget.onChangeTheme(themeMode);
  }


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
    selectedIcon = getIconTypeFromString(value[3]);
    image = Image.memory(value[4]);
    presentdate =
        value[5] != null ? DateTime.parse(value[5].toString()) : DateTime.now();
    eventUpdateDate = DateTime.parse(value[6]);
    checkGallery = false;
    formattedDate = DateFormat('yyyy-MM-dd').format(eventUpdateDate);
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
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surfaceTint,
            ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 10, 3, 0),
                child: Row(
                  children: [
                    Text(
                      formattedDate,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      onPressed: () {},
                      iconSize: 24,
                      icon:
                          getIconWidget(selectedIcon.toString().split('.')[1]),
                    )
                  ],
                ),
              ),
              _buildImagePicker(),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 3),
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
                  readOnly: true,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
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
                  readOnly: true,
                  maxLines: 13,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 15,),
              ElevatedButton(
                onPressed: () {
                  Get.to(()=> update.EventUpdate(onChangeTheme: _changeThemeMode), arguments: value);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                  backgroundColor:  const Color.fromARGB(255, 137, 156, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "수정 페이지로 이동",
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

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        //
      },
      child: Container(
        width: 390,
        height: 230,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 212, 221, 247),
          image: imageFile == null
              ? DecorationImage(
                  image: MemoryImage(value[4]),
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

  Widget getIconWidget(String iconString) {
    switch (iconString.toLowerCase()) {
      case 'sunny':
        return Icon(
          Icons.sunny,
          color: Colors.amber[400],
        );
      case 'waterdrop': // 'WaterDrop' 대신 'waterdrop'으로 수정
        return Icon(Icons.water_drop, color: Colors.blue[300]);
      case 'cloud':
        return Icon(
          Icons.cloud,
          color: Colors.grey[400],
        );
      case 'air':
        return Icon(
          Icons.air,
          color: Colors.blueGrey[200],
        );
      case 'acunit': // 'AcUnit' 대신 'acunit'으로 수정
        return Icon(
          Icons.ac_unit,
          color: Colors.blue[100],
        );
      default:
        return const Icon(Icons.error); // 기본값으로 오류 아이콘을 표시
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
} //END
