import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:secret_diary/maplocalview.dart';
import 'eventupdate.dart';
import 'test/datehandler.dart';
import 'test/sdiary.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late DatabaseHandler handler;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeSdiaryDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
              hintText: '검색어를 입력해 주세요.', suffixIcon: Icon(Icons.search)),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
      ),
      body: FutureBuilder(
          //앱을 키면 db와 연결되어 있는 상태, FutureBuilder는 또 리스트 만들어 쓰지 않고 메모리 만들어 저장된 값 가져가 쓰는거
          future: handler.querySdiary(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Sdiary>> snapshot) {
            if (snapshot.hasData) {
              //snapshot통해 화면구성
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data?.length, //async타입이라 ?로
                itemBuilder: (BuildContext context, int index) {
                  if (searchText.isNotEmpty &&
                      !snapshot.data![index].content
                          .toLowerCase()
                          .contains(searchText.toLowerCase())) {
                    return SizedBox.shrink();
                  }
                  return Slidable(
                    //왼쪽에서 오른쪽으로 당기는것
                    startActionPane: ActionPane(
                        motion: BehindMotion(), //
                        children: [
                          SlidableAction(
                            //버튼 눌렀을때 action
                            backgroundColor: Color.fromARGB(255, 190, 201, 244),
                            icon: Icons.edit,
                            label: 'Edit',
                            onPressed: (context) {
                              Get.to(EventUpdate(), arguments: [
                                snapshot.data![index].id,
                                snapshot.data![index].title,
                                snapshot.data![index].content,
                                snapshot.data![index].weathericon,
                                snapshot.data![index].lat,
                                snapshot.data![index].lng,
                                snapshot.data![index].image,
                                snapshot.data![index].actiondate,
                                snapshot.data![index].eventdate
                              ])!
                                  .then((value) => reloadData());
                            },
                          )
                        ]),
                    endActionPane: ActionPane(
                        motion: BehindMotion(), //
                        children: [
                          SlidableAction(
                            //버튼 눌렀을때 action
                            backgroundColor:
                                const Color.fromARGB(255, 255, 158, 151),
                            icon: Icons.delete,
                            label: 'Delete',
                            onPressed: (context) async {
                              Get.bottomSheet(
                                Container(
                                width: 500,
                                height: 250,
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                                color: Theme.of(context).colorScheme.secondaryContainer,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          await handler.deleteSdiary(
                                              snapshot.data![index].id!);
                                          snapshot.data!
                                              .remove(snapshot.data![index]);
                                          Get.back();
                                          setState(() {});
                                          Get.back();
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(400, 60),
                                          // backgroundColor: Color.fromARGB(255, 146, 148, 255),
                                          backgroundColor: Theme.of(context).colorScheme.errorContainer
                                        ),
                                        child: Text('DELETE', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                                        SizedBox(height: 10,),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: Size(400, 60),
                                          // backgroundColor: Color.fromARGB(255, 146, 148, 255),
                                          backgroundColor: Theme.of(context).colorScheme.surface
                                        ),
                                        child: Text('CANCEL', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)),
                                  ],
                                ),
                              ));
                            },
                          ),
                        ]),
                    child: GestureDetector(
                      onLongPress: () {
                        Get.to(MapLocationView(), arguments: [
                          snapshot.data![index].id,
                          snapshot.data![index].title,
                          snapshot.data![index].lat,
                          snapshot.data![index].lng,
                          snapshot.data![index].eventdate,
                        ])!
                            .then((value) => reloadData());
                      },
                      child: Card(
                        child: Container(
                          height: 350,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 420, // 이미지의 고정된 너비
                                  height: 200, // 컨테이너의 높이를 꽉 채우도록 설정
                                  child: Image.memory(
                                    snapshot.data![index].image,
                                    fit: BoxFit.cover,
                                    width: 100,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(270, 0, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(snapshot.data![index].eventdate ??
                                          'No Date'),
                                      // Text(snapshot.data![index].eventdate !=
                                      //         null
                                      //     ? DateFormat('yyyy-MM-dd').format(
                                      //         snapshot.data![index].actiondate!)
                                      //     : 'No Date'),
                                      IconButton(
                                        onPressed: () {},
                                        iconSize: 24,
                                        icon: getIconWidget(
                                            snapshot.data![index].weathericon ??
                                                ''),
                                      )
                                    ],
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].title,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  snapshot.data![index].content,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  //---Function---

  reloadData() {
    handler.querySdiary();

    setState(() {});
  }

  // 저장된 아이콘 값을 기반으로 아이콘 위젯을 반환
  Widget getIconWidget(String iconString) {
    switch (iconString.toLowerCase()) {
      case 'sunny':
        return Icon(
          Icons.sunny,
          color: Colors.amber[400],
        );
      case 'waterdrop':
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
      case 'acunit':
        return Icon(
          Icons.ac_unit,
          color: Colors.blue[100],
        );
      default:
        return Icon(Icons.error);
    }
  }
}
