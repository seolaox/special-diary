import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class EventInsert extends StatefulWidget {
  final Function(ThemeMode) onChangeTheme; 
  const EventInsert({super.key, required this.onChangeTheme});

  @override
  State<EventInsert> createState() => _EventInsertState();
}

class _EventInsertState extends State<EventInsert> {

    _changeThemeMode(ThemeMode themeMode) {
    widget.onChangeTheme(themeMode);
  }
    //location
  late Position currentPosition;
  late double latData;
  late double lngData;
  // late DatabaseHandler handler;
  late TextEditingController titleController;
  late TextEditingController contentController;
  late MapController mapController;
  XFile? imageFile; 
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
        // handler = DatabaseHandler();
    titleController = TextEditingController();  
    contentController = TextEditingController();  
    mapController = MapController();
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
        width: MediaQuery.of(context).size.width,
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









}//END